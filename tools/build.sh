#!/usr/bin/env bash
set -e # halt script on error

if [ $TRAVIS_PULL_REQUEST = "false" ]; then
  jekyll build
else
  echo "Not building, so long and thanks for all the fish!"
fi
