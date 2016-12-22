#!/bin/bash
set -e

make _site/prerendered/books/03-investigating-shape-and-size.html && ./tools/deploy.sh
make _site/pdf/books/03-investigating-shape-and-size.pdf && ./tools/deploy.sh

make _site/prerendered/books/06-geometry-and-proof.html && ./tools/deploy.sh
make _site/pdf/books/06-geometry-and-proof.pdf && ./tools/deploy.sh

#make all
#./tools/deploy.sh
