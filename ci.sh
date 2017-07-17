#!/bin/bash
set -e

make _site/prerendered/books/01-reasoning-and-proving.html.html && ./tools/deploy.sh
make _site/pdf/books/01-reasoning-and-proving.pdf && ./tools/deploy.sh

#make _site/prerendered/books/06-geometry-and-proof.html && ./tools/deploy.sh
#make _site/pdf/books/06-geometry-and-proof.pdf && ./tools/deploy.sh

#make all
#./tools/deploy.sh
