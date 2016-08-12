#!/usr/bin/env node
var fs = require('fs')
var url = require('url')
var path = require('path')
var Prince = require('prince')
var http = require('http')
var ecstatic = require('ecstatic')
var argv = require('minimist')(process.argv.slice(2))

var site = path.join(__dirname, '../_site')

// start a local server that Prince can target
http.createServer(
  ecstatic({ root: site })
).listen(8080)
console.log('Listening on :8080')

var book = argv._[0].replace('_site/', '')
var pdf = argv.o

console.log('Rendering ' + book + ' to ' + pdf)
Prince()
  .inputs(url.resolve('http://localhost:8080/', book))
  .output(pdf)
  .option('style', 'local-fonts.css')
  .timeout(30 * 60 * 1000)
  .execute()
  .then(done)
  .catch(done)

function done (result) {
  if (result && result.error) { console.error('ERROR', result.error) }
  if (result && result.stdout) { console.log(result.stdout) }
  if (result && result.stderr) { console.error(result.stderr) }
  process.exit()
}

