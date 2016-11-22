#!/bin/bash
set -e

make _site/prerendered/books/09-reasoning-and-proving-3.html && ./tools/deploy.sh
make _site/pdf/books/09-reasoning-and-proving-3.pdf && ./tools/deploy.sh

#make all
#./tools/deploy.sh
