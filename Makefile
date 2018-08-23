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

# Build books listed in QUICK_LIST
.PHONY: quick list-quick
quicklist:=$(patsubst %,_site/pdf/books/%.pdf,$(shell cat QUICK_LIST))
list-quick:
	@echo Books in quick list:
	@echo ========================================================================
	@echo $(quicklist) | xargs -n1 echo
	@echo ========================================================================
quick: list-quick $(quicklist)

ALL_BOOKS.txt:
	ls _books/*.html | sed s@_books@_site/pdf/books@ | sed s/.html/.pdf/ > $@
ALL_BUT_QUICK.txt: ALL_BOOKS.txt
	cat ALL_BOOKS.txt | grep -f QUICK_LIST -v > $@

.PHONY: all
all: ALL_BOOKS.txt
	make $(shell cat ALL_BOOKS.txt)

.PHONY: not-quick
# Build books NOT listed in QUICK_LIST (used for CircleCI parallelization)
notquicklist:=
not-quick: ALL_BUT_QUICK.txt
	@echo Books not in quick list:
	@echo ========================================================================
	@cat ALL_BUT_QUICK.txt
	@echo ========================================================================
	make $(shell cat ALL_BUT_QUICK.txt)



.PHONY: clean
clean:
	rm -rf _site
