#!/usr/bin/env bash
set -e # halt script on error

if [ $TRAVIS_PULL_REQUEST = "false" ]; then
  bundle exec jekyll build
  mkdir -p _site/books-prerendered
  for filename in _site/books/*.html; do
    ./node_modules/MathJax-node/bin/page2mml < "$filename" > "$build/books-prerendered/`basename $filename`";
  done
else
  echo "Not building, so long and thanks for all the fish!"
fi
