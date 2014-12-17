# Under the Hood

## Assembly: Jekyll

On their own, the individual files in [_lessons][1] aren't quite complete enough
to work as web pages--they're actually fragments that have to be embedded in
a complete HTML document, which includes a bunch of meta information (for example,
the location of the the "stylesheet" that controls the layout and aesthetics).

So, the way that embedding happens is with a widely used program called [Jekyll][2].
Jekyll takes the files in _lessons and assembles them into full HTML documents
according to the rules specified in [_config.yml][3].  Here's where the relevant
pieces are:

### Jekyll files and folders:

- [_layouts][4]: These are the templates used in the site.  Each lesson file has
  a bit of metadata at the top indicating its layout (e.g., `lesson` for *lesson.html*).
  If you look in *lesson.html*, you'll see `{{ content }}`: this is where the lesson's
  content gets inserted.  In turn, *lesson.html* itself gets embedded into *default.html*.
  
- [_includes][5]: These are little bits of (templated) HTML that get reused in 
  multiple places. They're just separated out into these files to avoid repetitive code.
  
- [_data][6]: A place for data files that can be referenced from HTML templates.
  Again, the reason being to avoid repetitive code.
  
(By the way: the obsession with avoiding repetitive code isn't (only) laziness!
It makes for far fewer bugs, because when you do find an error and fix it, it's
fixed everywhere.)

- [_sass][7]: The stylesheets.  These are actually written in [SCSS][8], which 
  is an extremely popular CSS preprocessor that provides more powerful syntax.
  Jekyll compiles them to CSS when it generates the site.

- [_books][8]: Each file in here turns into a book.  These files themselves are
  very minimal: just a bit of metadata about the book, whose actual content comes
  from files in _lessons.
  
### Running Jekyll

Normally, it's not actually necessary to run Jekyll yourself, because there's a
'hook' setup so that every time a change is committed to the repository, the
server automatically grabs the updates and runs Jekyll to regenerate the live site.
If you do want to run it, though, you'll need to sync the github repository to your
local computer, [install Jekyll](http://jekyllrb.com/docs/installation/), and then
run [`jekyll build`](http://jekyllrb.com/docs/usage/).

  
[1]: https://github.com/parkmath/parkmath/tree/gh-pages/_lessons
[2]: http://jekyllrb.com/docs/home/
[3]: https://github.com/parkmath/parkmath/blob/gh-pages/_config.yml
[4]: https://github.com/parkmath/parkmath/tree/gh-pages/_layouts
[5]: https://github.com/parkmath/parkmath/tree/gh-pages/_includes
[6]: https://github.com/parkmath/parkmath/tree/gh-pages/_data
[7]: https://github.com/parkmath/parkmath/tree/gh-pages/_sass
[8]: https://github.com/parkmath/parkmath/tree/gh-pages/_books
