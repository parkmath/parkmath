#!/usr/bin/env bash
set -e # halt script on error

# If this is the deploy branch, push it up to gh-pages
if [[ $CIRCLE_BRANCH = ${DEPLOY_BRANCH} ]] || [[ $TRAVIS_BRANCH = ${DEPLOY_BRANCH} ]]; then
  echo "Get ready, we're pushing!"
  cd _site
  if [ ! -d .git ]; then
    git init
  fi
  git config user.name "Travis-CI"
  git config user.email "travis@somewhere.com"
  git add .
  git commit -m "CI deploy"
  git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:master > /dev/null 2>&1
else
  echo "Not a publishable branch so we're all done here"
fi
