
# Editing a Lesson

The entire content of the textbook, as well as the data assembling, formatting, and printing the books, is stored on Github, at http://github.com/parkmath/parkmath.  The lessons themselves are in the a folder called [_lessons](https://github.com/parkmath/parkmath/tree/gh-pages/_lessons).

## Prose
**Prose** is a web app that will let you edit the lesson HTML files on github directly.  The "official" one is at http://prose.io, but I'm running a modified version at http://prose.anandthakker.net. (The modified version has some extra features, like equation preview, and I'm hoping to add some more.)

When you first go to Prose, it'll ask you to authorize access your Github account:

![prose-authorize.png](images/prose-authorize.png)

Once that's done (and, warning, it might take a minute), you should be logged in.  You'll see something like this:

![prose-logged-in.png](images/prose-logged-in.png)

Over on the right under Groups, click on "parkmath", which should bring up a project--also called "parkmath"--in the center of the screen.  Click that.

Now, if you see this: 

![prose-files.png](images/prose-files.png)

Then you're good to go--edit away!  When you click a lesson to edit it, you'll be on a screen like the one below.  A few notes:
- The {% raw %} and {% endraw %} at the beginning/end are annoying necessities--just leave 'em there.
- The eye-shaped icon on the right allows you to preview your changes, including rendering LateX into pretty equations.  The headers and footers of the page are buggy in preview mode, but it should still give you a sense of what your changes will look like before you save them.
- The "Published"/"Unpublished" button does basically what you'd expect: if a lesson is unpublished, it won't show up in the list on the live website.  Currently, most of the lessons unpublished because I'm in the process of going through and doing the final round of fixes on each lesson.  But feel free to publish them if you wanna see them live--easy enough to unpublish later.
- Speaking of which, the live site, which gets updated every time you save a change in Prose, is here: [http://parkmath.anandthakker.net](http://parkmath.anandthakker.net)

![prose-editing.png](images/prose-editing.png)



## About HTML

- HTML documents have heirarchical structure.
- That structure is marked by **tags**, e.g., `<p>This is a paragraph</p>`.  In that example, `<p>` is the 'opening' tag, and `</p>` is the 'closing tag'.  Together the whole thing is called an **element**.
- Common elements:
  - `<p>...</p>`: a paragraph.
  - `<h1>...</h1>`, `<h2>...</h2>`, ... `<h6>...</h6>`: a heading or subheading
  - `<section>...</section>`: a meaningful section of the document.
  - `<div>...</div>`: a smaller chunk ('division') of the document.
  - `<a>...</a>`: a link.
  - `<figure>...</figure>`: a figure.
  - `<img>`: an image; often goes inside a `figure`; note that `img` elements have
    **no closing tag**.
  - `<ul>...</ul>`: an unordered list, full of list items like so: `<li>...</li>`.
- Tags can be annotated with meta-information, like so: `<img src="http://blahblah.com/my-awesome-picture.jpg">` or `<div class="problem">...</section>`.
  In the first one, the required `src` attribute provides the location of an image file.  In
  the second one, the optional `class` attribute is a way to assign an author-defined
  category to an element.

Because they are used as part of HTML's syntax, three symbols--&lt;, &gt;, and &amp;--must
be written using the following special codes: `<`=`&lt;`, `>`=`&gt;`, `&`=`&amp;`.

## Lesson Files:

The HTML files for all of the lessons (including habits lessons) are located in the [_lessons](/parkmath/parkmath/tree/gh-pages/_lessons) directory.  Each one looks
like this:

```html
<article>
  <section class="development">

    <h2>Introduction</h2>

    <p>... intro text ...</p>

    <div class="problem">
      <p>...problem text...</p>
    </div>
    
    <div class="problem">
      <p>...problem text...</p>
      <p class="problem-part">...part a text...</p>
      <p class="problem-part">...part b text...</p>
    </div>
    
    <h2>Development</h2>
    [... more text and problems ...]
    
    <h2>Practice</h2>
    [... more text and problems ...]
  </section>
  
  <section class="problems">
    <h2>Problems</h2>
    [... more text and problems ...]
    
    <h2>Exploring in Depth</h2>
    [... more text and problems ...]
  </section>
</article>
```

## Equations

Equations, written in Latex, can go anywhere that plain text can go, simply by
surrounding the Latex expression with dollar signs.  E.g., `<p>Find integers to
solve the equation $ x^3 + y^3 = z^3 $.</p>`.

Note that since dollar signs are used to indicate a Latex equation, if you want
to have an actual dollar sign in the text, it must be preceeded with a backslash,
like so: `<p>...select 21 coins which have a total value of exactly
\$1.00...</p>`.

## Figures

Figures should go within the `<div>` of the problem they're associated with, but outside of the `<p>` elements, which are primarily for text.  (Rare exceptions to this are possible when you want an image to be right in the flow of the text.)

Here's how:
```html
<figure class="fig-50">
  <img src="../images/....">
</figure>
```

`fig-50` scales the figure down so that its width is 50% of the width of the problem/section it's in. `fig-25` analogously makes it 25% of the width.


## Other Markup

- To emphasize text (i.e., italicize it), use `<em>blah blah blah</em>`; but to bold a vocabulary term, typically done in the sentence definining it, use `<em class="vocab">vocabulary term</em>`.
- To force an element to appear on a new page add the `new-page` class to it.  E.g., `<div class="problem">` would become `<div class="problem new-page">`.
- Similarly, use the `new-column` class to force something to break to the next column.
- Problems will attempt to NOT be broken up across pages or columns.  If there's a long problem that you want to allow this for, use the class `allow-break`.
- `<ul>` elements normally put each list item on a new line.  To make the list go horizontally, add the `horizontal` class: `<ul class="horizontal"> <li>thing 1</li> <li>thing 2</li> <li>thing 3</li> </ul>`.
- `<ul>` elements are, by default, not bulleted.  To add bullets, use the `<ul class="bulleted">...</ul>`
- To include 'subparts' within a problem part (`i.`, `ii.`, `iii.`, etc.), use an ordered list with the `subparts` class: `<ol class="subparts"><li>Thing 1</li><li>Thing 2</li></ol>`
- Sometimes, you want two images to go side-by-side.  Use the `two-up` class for
  this: `<figure class="two-up"> <img src="...first image"> <img src="...second images"> </figure>`.  Similarly, `three-up` and `four-up` also work.

## Custom Books

To add a custom book made of exiting lessons from other books, just add a file
like 99-my-custom-book.html in the [`_books/`](https://github.com/parkmath/parkmath/tree/editing/_books) directory that looks like this:

```yaml
---
layout: custom-book
book: 99
title: My Custom Book
habits-color: rgb(0, 179, 208)
lessons:
- book: 7
  lesson: 0
- book: 10
  lesson: 0
- book: 7
  lesson: 1
  order: 1
- book: 7
  lesson: 2
  order: 2
- book: 10
  lesson: 1
  order: 3
---
```

Notes:

 - Be careful to match the indentation shown above.
 - The `order` property lets you renumber the lessons within the custom book.
 - The `book` property can be omitted, in which case the title of the book will be printed as 'My Custom Book' instead of 'Book 99: My Custom Book'
