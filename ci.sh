#!/bin/bash
set -e

make _site/prerendered/books/02-analytic-geometry.html && ./tools/deploy.sh
make _site/pdf/books/02-analytic-geometry.pdf && ./tools/deploy.sh
#make all
#./tools/deploy.sh
