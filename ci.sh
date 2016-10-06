#!/bin/bash
set -e

make _site/pdf/books/02-0-2-represent-symbolically.pdf && ./tools/deploy.sh
#make all
./tools/deploy.sh
