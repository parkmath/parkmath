SHELL=/bin/bash -o pipefail

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
		| sed 's/\\\$$/$$/' \
		> $@

_site/pdf/%.pdf: _site/prerendered/%.html
	mkdir -p $(dir $@)
	./tools/render-pdf.js $^ -o $@

books := $(patsubst _books/%.html,_site/pdf/%.pdf,$(wildcard _books/*.html))
.PHONY: all
all: $(books)

.PHONY: clean
clean:
	rm -rf _site
