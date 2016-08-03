#!/bin/bash
set -e

# Make and deploy book 1 and custom book
travis_wait make _site/pdf/01-reasoning-and-proving.pdf
travis_wait make _site/pdf/07-trigonometry-in-the-coordinate-plane.pdf
travis_wait make _site/pdf/99-custom-1.pdf
./tools/deploy.sh

# Now make book 5 with extra long timeout, and deploy it afterwards
travis_wait 30 make _site/pdf/05-reasoning-and-proving-2.pdf
./tools/deploy.sh

# And finally, make and deploy any other books, too
for b in $(ls _books/*.html) ; do
  travis_wait make _site/pdf/$(basename $b .html).pdf
done

./tools/deploy.sh
