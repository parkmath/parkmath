#!/bin/bash
set -e

make _site/prerendered/books/ways-of-counting-and-ways-of-modeling && ./tools/deploy.sh
make _site/pdf/books/ways-of-counting-and-ways-of-modeling && ./tools/deploy.sh

#make all
#./tools/deploy.sh
