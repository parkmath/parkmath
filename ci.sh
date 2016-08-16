#!/bin/bash
set -e

make _site/pdf/books/08-functions-and-models-1.pdf && ./tools/deploy.sh
#make all
#./tools/deploy.sh
