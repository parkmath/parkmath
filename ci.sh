#!/bin/bash
set -e

make _site/pdf/02-analytic-geometry.pdf && ./tools/deploy.sh
#make all
#./tools/deploy.sh
