#!/usr/bin/env node
var fs = require('fs')
var url = require('url')
var path = require('path')
var Prince = require('prince')
var http = require('http')
var ecstatic = require('ecstatic')

var site = path.join(__dirname, '../_site')
var books = path.join(site, 'books-prerendered')
http.createServer(
  ecstatic({ root: site })
).listen(8080)

console.log('Listening on :8080')

var booknames = fs.readdirSync(books).map(function (book) {
  return path.basename(book)
})

;(function next (err, result) {
  if (err) { console.error('ERROR', err) }
  if (result) {
    console.log(result.stdout)
    console.error(result.stderr)
  }
  if (booknames.length === 0) {
    console.log('\nFinished rendering PDFs.')
    process.exit()
  }
  var book = booknames.shift()
  var pdf = book.replace(/html$/, 'pdf')
  console.log('Rendering ' + book + ' to ' + pdf)
  Prince()
    .inputs(url.resolve('http://localhost:8080/books-prerendered/', book))
    .output(path.join(site, 'pdf', pdf))
    .option('style', 'local-fonts.css')
    .timeout(60000)
    .execute()
    .then(function (result) { next(null, result) })
    .catch(next)
})()
