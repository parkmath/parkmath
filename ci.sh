#!/bin/bash
set -e

#make _site/prerendered/books/08-functions-and-models-1.html && ./tools/deploy.sh
#make _site/pdf/books/08-functions-and-models-1.pdf && ./tools/deploy.sh
#make _site/prerendered/books/99-custom-1.html && ./tools/deploy.sh
#make _site/pdf/books/99-custom-1.pdf && ./tools/deploy.sh
make _site/prerendered/books/97-ways-of-counting-and-ways-of-modeling.html  && ./tools/deploy.sh
make _site/pdf/books/97-ways-of-counting-and-ways-of-modeling.pdf  && ./tools/deploy.sh
make _site/prerendered/books/05-reasoning-and-proving-2.html  && ./tools/deploy.sh
make _site/pdf/books/05-reasoning-and-proving-2.html.pdf  && ./tools/deploy.sh

#make _site/prerendered/books/06-geometry-and-proof.html && ./tools/deploy.sh
#make _site/pdf/books/06-geometry-and-proof.pdf && ./tools/deploy.sh

#make all
#./tools/deploy.sh
