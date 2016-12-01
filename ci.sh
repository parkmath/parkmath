#!/bin/bash
set -e

make _site/prerendered/books/Ways of Counting & Ways of Modeling && ./tools/deploy.sh
make _site/pdf/books/Ways of Counting & Ways of Modeling  && ./tools/deploy.sh

#make all
#./tools/deploy.sh
