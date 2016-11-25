#!/bin/bash
set -e

make _site/prerendered/books/97-Logarithms-and-Sundries.html && ./tools/deploy.sh
make _site/pdf/books/97-Logarithms-and-Sundries.pdf && ./tools/deploy.sh

#make all
#./tools/deploy.sh
