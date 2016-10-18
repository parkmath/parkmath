#!/bin/bash
set -e

make _site/prerendered/books/04-quadratics.html && ./tools/deploy.sh
make _site/pdf/books/04-quadratics.pdf && ./tools/deploy.sh


make _site/prerendered/books/08-functions-and-models-1.html && ./tools/deploy.sh
make _site/pdf/books/08-functions-and-models-1.pdf && ./tools/deploy.sh


make _site/prerendered/books/02-analytic-geometry.html && ./tools/deploy.sh
make _site/pdf/books/02-analytic-geometry.pdf && ./tools/deploy.sh


#make all
#./tools/deploy.sh
