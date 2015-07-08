// usage:
// node pull-html.js htmldir frontmatterdir filename.html
var fs = require('fs')
var path = require('path')
var split = require('split')

var f = process.argv[4]

var front = true
var content = false

var html = fs.createWriteStream(path.join(process.cwd(), process.argv[2], path.basename(f)))
var frontmatter = fs.createWriteStream(path.join(process.cwd(), process.argv[3], path.basename(f)))

fs.createReadStream(f)
  .pipe(split())
  .on('data', function (line) {
    if (/\{\%\s*endraw/.test(line.toString())) {
      content = false
      return
    }

    if (content) {
      html.write(line)
      html.write('\n')
    } else if (/\{\%\s*raw/.test(line.toString())) {
      content = true
      front = false
    } else if (front) {
      frontmatter.write(line)
      frontmatter.write('\n')
    }
  })
  .on('end', function () {
    html.end()
    frontmatter.end()
  })
