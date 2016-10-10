#!/bin/bash
set -e

make _site/prerendered/books/04-quadratics.html && ./tools/deploy.sh
make _site/pdf/books/04-quadratics.pdf && ./tools/deploy.sh
#make all
#./tools/deploy.sh
