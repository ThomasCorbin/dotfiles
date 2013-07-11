// ==UserScript==
// @name        Sans serif fonts for american thinker
// @namespace   americanthinker
// @description Changes serif font used for viewing some books in HTML view to sans serif Verdana to improve readability
// @include     http://americanthinker.com/*
// @match       http://americanthinker.com/*
// @version     1.0
// ==/UserScript==

var css = document.createElement('style');
css.type = 'text/css';
css.innerHTML = "body #HtmlView { font-family: verdana, sans-serif !important; }";
document.getElementsByTagName('head')[0].appendChild(css);
