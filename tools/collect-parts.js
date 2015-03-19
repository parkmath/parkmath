
var tok = require('html-tokenize');
var through = require('through2');

var buf;
var inProblem = false;
var postProblem = false;
var depth;

function closeProblem(stream) {
  inProblem = false
  postProblem = false

  var after = '';
  if(buf[buf.length-1][0] === 'text') {
    after = buf.pop()[1];
  }
  stream.push(buf.map(function(b) {return b[1]}).join(''))
  stream.push('</div>')
  stream.push(after)
}

var sc = {};
'!-- area base br col embed hr img input keygen link menuitem meta param source track wbr'
  .split(' ').forEach(function (t) { sc[t] = true });
function selfClosing(name) { return Object.prototype.hasOwnProperty.call(sc, getTag(name)); };

function getTag(open) {
  return open.match(/[^\s<>]+/)[0];
}

process.stdin
  .pipe(tok())
  .pipe(through.obj(function(token, enc, next) {
    token[1] = token[1].toString();
    
    if(token[0] === 'open') {
      // we're collecting a problem but we've hit a non problem-part or
      // figure, so, output the collected buffer, end the problem, and go
      // back to normal pass-through.
      if(inProblem && depth === -1
      && !/class=\"problem-part\"/.test(token[1])
      && !/^<figure/.test(token[1])) {
        closeProblem(this)
      }

      // when we start a problem, start buffering so we can collect up the
      // following problem parts and figures before closing it out.
      if(/^<div/.test(token[1]) && /class=\"problem\"/.test(token[1])) {
        inProblem = true
        postProblem = false
        depth = -1
        buf = []
      }
    }
        
    if(inProblem) {
      if(token[0] === 'open' && !selfClosing(token[1])) depth++;
      else if(token[0] === 'close') depth--;
      
      // this is the closing </div> of the problem we're collecting.
      // don't buffer it!
      if(depth === -1 && !postProblem && token[0] === 'close') {
        postProblem = true
      }
      // this is the closing div of the current problem's *container*--end
      // the problem and then close the container.
      else if(depth < -1 && postProblem && token[0] === 'close') {
        closeProblem(this)
        this.push(token[1])
      }
      // we're collecting the problem -- just buffer.
      else {
        buf.push(token)
      }
    }
    // we're not collecting the problem: pass-through
    else {
      this.push(token[1])
    }
    
    next()


    
  }))
  .pipe(process.stdout);
