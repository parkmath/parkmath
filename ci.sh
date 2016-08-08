#!/bin/bash
set -e
make _site/pdf/05-reasoning-and-proving-2.pdf && ./tools/deploy.sh
#make _site/pdf/01-reasoning-and-proving.pdf && ./tools/deploy.sh
#make _site/pdf/99-custom-1.pdf && ./tools/deploy.sh
make _site/pdf/99-custom-2.pdf && ./tools/deploy.sh
#make all
./tools/deploy.sh
