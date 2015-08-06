var fs = require('fs')
var cheerio = require('cheerio')

var filename = process.argv[2]

var input = fs.readFileSync(filename, 'utf-8')

var $ = cheerio.load(input, { decodeEntities: false })

$('.problem').each(function () {
  var problem = $(this)
  var c = problem.contents()[0]
  if (c.type === 'text') {
    var data = c.data
    c.data = ''
    c = $('\n<p>\n' + data + '\n</p>\n')
  }
  problem.prepend(c)
})

fs.writeFileSync(filename, $.html())
