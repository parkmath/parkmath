#!/usr/bin/env bash
set -e # halt script on error

if [ "$TRAVIS_PULL_REQUEST" = "false" ]; then
  bundle exec jekyll build
  mkdir -p _site/books-prerendered
  for filename in _site/books/*.html; do
    echo "Prerendering equations for $filename"
    # Note:
    # the sed replaces change the 'overline' character, because the one that
    # mathjax uses gets rendered (by prince) with way too much extra space.
    ./tools/prerender.js --no-speech --extensions TeX/cancel < "$filename" \
      | sed 's/¯/_/g' \
      > "_site/books-prerendered/`basename $filename`";
  done
  mkdir -p _site/pdf
  ./tools/render-pdfs.js
else
  echo "Not building, so long and thanks for all the fish!"
fi
