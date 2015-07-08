// usage:
// node wrap-html.js htmldir frontmatterdir filename.html
var fs = require('fs')
var path = require('path')
var next = require('next-stream')

var f = process.argv[4]

var html = fs.createReadStream(path.join(process.cwd(), process.argv[2], path.basename(f)))
var frontmatter = fs.createReadStream(path.join(process.cwd(), process.argv[3], path.basename(f)))

var output = fs.createWriteStream(f)

next([frontmatter, '{% raw %}\n', html, '{% endraw %}\n'])
  .pipe(output)
