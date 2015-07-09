// usage:
// node check-structure.js filename.html
var fs = require('fs')
var path = require('path')
var chalk = require('chalk')
var split = require('split')
var concat = require('concat-stream')
var cheerio = require('cheerio')

process.argv.slice(2).forEach(doFile)
var lineLengths = []
function getLine (index) {
  var count = 0
  var i
  for (i = 0; i < lineLengths.length; i++) {
    count += lineLengths[i]
    if (count > index) break
  }
  return i
}

function check (name, html) {
  var passed = 0
  var failed = 0
  console.log(chalk.blue(name))

  var $ = cheerio.load(html.toString(), {
    withStartIndices: true
  })
  var habit = /^[0-9]{1,2}-0/.test(name)
  // var summary = /summary/.test(name)

  if (!habit) {
    is($('article > *:first-child'), 'h1', 'h1 title element')
  }

  // check development section is in expected location
  var expected = habit ? 'article > *:nth-child(1)' : 'article > *:nth-child(2)'
  is($('.development'), expected, 'development section is first')
  is($('.development').next(), '.problems', 'problems section is after development')
  $('.problem-part').each(function (i, n) {
    n = $(n)
    ok(n.closest('.problem').length > 0, n, 'Problem part contained in problem')
  })

  function is (node, selector, message) {
    return ok(node.is(selector), node, message)
  }
  function ok (isOk, node, message) {
    if (isOk) {
      passed++
      console.log(chalk.green('[ PASSED ]', message))
    } else {
      failed++
      var content
      var location
      if (node.length > 0) {
        // hack to grab first line of offending node
        var n = node.clone()
        n.wrap($('<div></div>'))
        content = n.parent().html().trim().split('\n')[0]
        location = getLine(node[0].startIndex)
      } else if (node.parent()) {
        node = node.parent()
      }
      if (location) { message = 'Line ' + location + ': ' + message }
      console.log(chalk.red('[ FAILED ]', message))
      if (content) {
        console.log('\t', content)
      }
    }
  }

  var total = passed + failed
  if (failed === 0) {
    console.log(chalk.green('Passed all ' + total + ' checks.'))
  } else {
    console.log(chalk.red('Failed ' + failed + ' of ' + total + ' checks.'))
  }
}

function doFile (f) {
  var name = path.basename(f)

  var html = concat(check.bind(null, name))
  var content = false
  fs.createReadStream(f)
  .pipe(split())
  .on('data', function (line) {
    lineLengths.push(line.toString().length)
    if (/\{\%\s*endraw/.test(line.toString())) {
      content = false
      return
    }

    if (content) {
      html.write(line)
      html.write('\n')
    } else if (/\{\%\s*raw/.test(line.toString())) {
      content = true
    }
  })
  .on('end', function () {
    html.end()
  })
}
