#!/bin/bash
set -e

make _site/prerendered/books/05-reasoning-and-proving-2.html && ./tools/deploy.sh
make _site/pdf/books/05-reasoning-and-proving-2.pdf && ./tools/deploy.sh

#make all
#./tools/deploy.sh
