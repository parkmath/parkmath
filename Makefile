SHELL=/bin/bash -eo pipefail

_site/books/%.html:
	bundle exec jekyll build

_site/lessons/%.html:
	bundle exec jekyll build

.PRECIOUS: _site/prerendered/%.html

_site/prerendered/%.html: _site/%.html
	mkdir -p $(dir $@)
	cat $^ \
		| node_modules/mathjax-node/bin/page2html \
			--no-speech \
		  --extensions TeX/cancel \
		| sed 's/\\\$$/$$/g' \
		| sed 's/<script.*MathJax.js.*>/<script>/' \
		> $@

_site/pdf/%.pdf: _site/prerendered/%.html
	mkdir -p $(dir $@)
	./tools/render-pdf.js $^ -o $@

BOOKS.txt:
	ls _books/*.html | sed s@_books@_site/pdf/books@ | sed s/.html/.pdf/ > $@

.PHONY: all
all: $(shell cat BOOKS.txt)

.PHONY: quick not-quick list-quick list-not-quick
# Build books listed in QUICK_LIST
quicklist:=$(patsubst %,_site/pdf/books/%.pdf,$(shell cat QUICK_LIST))
list-quick:
	@echo Books in quick list:
	@echo $(quicklist) | xargs -n1 echo
	@echo ========================================================================
quick: list-quick $(quicklist)

# Build books NOT listed in QUICK_LIST (used for CircleCI parallelization)
notquicklist:=$(shell cat BOOKS.txt | grep -f QUICK_LIST -v)
list-not-quick:
	@echo Books not in quick list:
	@echo $(notquicklist) | xargs -n1 echo
	@echo ========================================================================
not-quick: list-not-quick $(notquicklist)

.PHONY: clean
clean:
	rm -rf _site
