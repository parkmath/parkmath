#!/bin/bash
set -e

make _site/prerendered/books/05-reasoning-and-proving-2.html && ./tools/deploy.sh
make _site/pdf/books/05-reasoning-and-proving-2.pdf && ./tools/deploy.sh
make _site/prerendered/books/99-custom-1.html && ./tools/deploy.sh
make _site/pdf/books/99-custom-1.pdf && ./tools/deploy.sh

#make _site/prerendered/books/06-geometry-and-proof.html && ./tools/deploy.sh
#make _site/pdf/books/06-geometry-and-proof.pdf && ./tools/deploy.sh

#make all
#./tools/deploy.sh
