
var fs = require('fs');
var trumpet = require('trumpet');

var alphabetStart = 'a'.charCodeAt(0);

module.exports = renumber = function() {
  var tr = trumpet();
  var problemNumber = 1;
  var partNumber = 0;
  
  tr.selectAll('.problem', function(problem) {
    problem.setAttribute('data-problem-number', problemNumber++);
    partNumber = 0;
  });
  tr.selectAll('.problem-part', function(part) {
    part.setAttribute('data-part', String.fromCharCode(alphabetStart + partNumber++))
  });
  
  return tr;
}

// cli
if(require.main === module) {
  if(process.argv.length <= 2) {
    var r;
    process.stdin.pipe(r = renumber()).pipe(process.stdout);
  }
  else {
    process.argv.slice(2).forEach(function(filename) {
      var r;
      var fileread = fs.createReadStream(filename);
      var tempfile = 'temp/temp2';
      var tempWrite = fs.createWriteStream(tempfile);
      fileread
      .pipe(r = renumber())
      .pipe(tempWrite)
      .on('finish', function() {
        console.log('transformed; now rewriting.');
        fs.createReadStream(tempfile).pipe(fs.createWriteStream(filename));
      });
      fileread.on('end', function() {
        console.log("renumbering ended");
        r.resume()
      })
    })
  }
}
