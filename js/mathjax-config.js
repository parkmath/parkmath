---
---

{% include mathjax-config.js %}

MathJax.Hub.Config(config);
MathJax.Ajax.loadComplete('{{ "/js/mathjax-config.js" | prepend: site.baseurl | prepend: site.url }}');
