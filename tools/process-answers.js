
/*
 * Takes in:
 *  - Raw html file of answers document exported by InDesign
 *  - Directory containing EqnXXX.clean.tex files that correspond to the EqnXXX.eps images linked in the answers document. (Created with convert-equations.sh)
 *  - 2-digit book number (02, 11, etc.)
 *
 * Outputs: simple answer document with equations "inlined", other images properly referenced, and extra HTML cruft removed
 */

var fs = require('fs')
var path = require('path')
var cheerio = require('cheerio')

var book = String(process.argv[2])
var filename = process.argv[3]
var equationDir = process.argv[4]

if (book.length === 1) { book = `0${book}` }
var content = fs.readFileSync(filename, 'utf-8')
  .replace(/\$/g, '\\$') // escape pre-exisitng dollar signs


var $ = cheerio.load(content, { decodeEntities: false })

// preprocess every <img> tag
$('img').each(function () {
  var img = $(this)
  var src = img.attr('src')
  if (/Eqn.*\.eps/.test(src)) {
    // inline equaitons
    var tex = path.join(equationDir, path.basename(src).replace(/\.eps/i, '.clean.tex'))
    if (fs.existsSync(tex)) {
      tex = fs.readFileSync(tex, 'utf-8')
        .replace(/</g, '&lt;')
        .replace(/&/g, '&amp;')
        .replace(/\n/g, ' ')

      tex = unwrap(tex, '\\[', '\\]')
      tex = unwrap(tex, '{', '}')

      if (tex.startsWith('$')) {
        tex = tex.slice(1, tex.lastIndexOf('$'))
      }

      tex = `<span>$${tex.replace(/\$/g, '\\$')}$</span>` // escape non-delimiter dollar signs

      const imgHtml = img.html()
      img.replaceWith(tex)
      console.error(`Replacing ${src} with ${tex}`)
    }
  } else {
    var fixedSrc = unescape(src.replace(/^.*-web-images/, `images/${book}-answers`))
    var fullpath = path.join(__dirname, `../${fixedSrc}`)
    var extensions = ['', '.jpg', '.png']
    while (extensions.length && !fs.existsSync(fullpath + extensions[0])) {
      extensions.shift()
    }
    if (extensions.length) {
      img.attr('src', fixedSrc + extensions[0])
    } else {
      console.error(`Warning: missing image ${fixedSrc}`)
    }
  }
})

// strip classes added by InDesign, and unwrap them if they're immediate child of <td>
$('p').each(function () {
  var p = $(this)
  p.removeAttr('class')
  if (p.parent().is('td')) {
    p.replaceWith(p.html())
  }
})

var lesson = 0

var tableHeader = `

|problem|answer|
|-------|------|
`

$('table').each(function () {
  var table = $(this)
  if (table.parent().is('td')) { return true }
  lesson++
  var title = table.prev('p')
  title = clean(title ? title.text() : '')
  if (!/^\s*lesson/i.test(title)) {
    title = `Lesson ${lesson} ${title}`
  }

  var outfile = path.join(__dirname, `../_answers/${book}-${lesson}-answers.md`)
  var out = fs.createWriteStream(outfile)

  out.write(`
## ${title}
`)
  out.write(tableHeader)

  table.find('tr').each(function () {
    var cells = $(this).children('td')
    var problem = clean($(cells.get(0)).text())
    var answer = clean($(cells.get(1)).html())
    out.write(tableRow([problem, answer]) + '\n')
  })
})


function tableRow (arr) {
  return `|${arr.map(clean).join('|')}|`
}

function unwrap (str, left, right) {
  if (str.startsWith(left) && str.endsWith(right)) {
    return str.slice(left.length, -right.length)
  }
  return str
}

function clean (str) {
  return (str || '')
    .trim()
    .replace(/\s+/g, ' ')
    .replace(/\s*\t\s*/g, '  ')
    .replace(/\|/g, '\\|')
}

