SHELL=/bin/bash -o pipefail

_site:
	bundle exec jekyll build

.PRECIOUS: _site/books-prerendered/%.html
_site/books-prerendered/%.html: _site
	mkdir -p $(dir $@)
	cat _site/books/$*.html \
		| node_modules/mathjax-node/bin/page2html \
			--no-speech \
		  --extensions TeX/cancel \
		| sed 's/\\\$$/$$/' \
		> $@

_site/pdf/%.pdf: _site/books-prerendered/%.html
	mkdir -p $(dir $@)
	./tools/render-pdf.js $^ -o $@

books := $(patsubst _books/%.html,_site/pdf/%.pdf,$(wildcard _books/*.html))
.PHONY: all
all: $(books)

.PHONY: clean
clean:
	rm -rf _site
