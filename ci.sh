#!/bin/bash
set -e

make _site/prerendered/books/99-ways-of-counting-and-ways-of-modeling.html && ./tools/deploy.sh
make _site/pdf/books/99-ways-of-counting-and-ways-of-modeling.html && ./tools/deploy.sh

#make all
#./tools/deploy.sh
