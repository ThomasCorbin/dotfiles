// ==UserScript==
// @name           Irj remove share
// @namespace      http://corbin.com
// @description    Remove share links from IJR
// @include        http://ijreview.com/*
// @include        http://*.ijreview.com/*
// @version        1.0
// ==/UserScript==

var div = document.getElementById("postheader_share");
if (div) {
    // div.style.display = "none"; // Hides it
    // Or

    // Removes it entirely
    div.parentNode.removeChild(div); 
}
