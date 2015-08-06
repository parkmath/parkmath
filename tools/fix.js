var fs = require('fs')
var cheerio = require('cheerio')

var filename = process.argv[2]

var input = fs.readFileSync(filename, 'utf-8')

var $ = cheerio.load(input, { decodeEntities: false })

$('.problem').each(function () {
  var problem = $(this)
  var contents = problem.contents()
  var newContents = []
  for (var i = 0; i < contents.length; i++) {
    var c = contents.get(i)
    if (c.type === 'text') {
      c = $('\n<p>\n' + c.data + '\n</p>\n')
    }
    newContents.push(c)
  }
  problem.html('')
  problem.append.apply(problem, newContents)
})

fs.writeFileSync(filename, $.html())
