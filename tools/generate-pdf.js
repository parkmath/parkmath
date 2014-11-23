
var fs = require('fs');
var path = require('path');
var tmp = require('tmp');
var mathjax = require('prerender-mathjax').processHTML;
var concat = require('concat-stream');
var prince = require('prince');

tmp.setGracefulCleanup();

function pdf(inputFile, outputFile) {
  console.log(inputFile);
  fs.createReadStream(inputFile).pipe(concat(function(html) {
    html = html.toString().replace('/parkmath/','/');
    mathjax(html, {
      renderer: 'NativeMML',
      MathJax: {
        menuSettings: {semantics: true},
        SVG: {font: "TeX"},
        // processEscapes: true // handle dollar sign issues
      }
    }).then(function(result) {
      console.log("Got prerendered HTML");
      tmp.file(function(err, tempfile, fd){
        if(err) {
          console.error(err);
          exit(1);
        }
        var ws = fs.createWriteStream(tempfile);
        ws.end(result);
        prince({
          fileroot: path.join(__dirname, '../_site')
        })
        .inputs(tempfile)
        .output(outputFile)
        .execute()
        .then(function() {
          console.log("OK: done writing ", outputFile);
          process.exit();
        }, function(error) {
          console.error("ERROR:", error);
          process.exit(1);
        })
      });
    });
  }));
}

if(require.main === module) {
  
  pdf(process.argv[2], process.argv[3]);

}
