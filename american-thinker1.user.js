// ==UserScript==
// @name           San-serify
// @namespace      http://corbin.com
// @description    Change serif fonts to san-serif
// @include        http://americanthinker.com/*
// @include        http://*.americanthinker.com/*
// @include        http://redstate.com/*
// @include        http://*.redstate.com/*
// @include        http://townhall.com/*
// @include        http://*.townhall.com/*
// @include        http://hotair.com/*
// @include        http://*.hotair.com/*
// @include        http://forbes.com/*
// @include        http://*.forbes.com/*
// @include        http://powerlineblog.com/*
// @include        http://*.powerlineblog.com/*
// @include        http://commentarymagazine.com/*
// @include        http://*.commentarymagazine.com/*
// @include        http://ricochet.com/*
// @include        http://*.ricochet.com/*
// @include        http://nationalreview.com/*
// @include        http://*.nationalreview.com/*
// @version        1.0
// ==/UserScript==

// GM_addStyle(.articleContent .module .text p {
//     font-family: Verdana; }
// .articleContent .module .text p {
//     font-size: 12px;
//     line-height:14px; }
// );


//  from this: http://ubuntuforums.org/showthread.php?t=2127410

var font = new Array();
font['mono'] = 'Droid Sans Mono';

// CHANGE THIS - This is where you define the font you want to use! Make sure the name is the name of the font and the url points to a valid font css file
//font['name'] = 'Source Sans Pro';
//font['url'] = 'http://fonts.googleapis.com/css?family=Source+Sans+Pro:400,700,400italic,700italic';

//font['name'] = 'Ubuntu';
//font['url'] = 'http://fonts.googleapis.com/css?family=Ubuntu:regular,bold&subset=Latin';

font['name'] = 'OpenSans';
font['url'] = 'http://fonts.googleapis.com/css?family=Open+Sans:400';

var frame;

var count;
var interval = setInterval(addFont, 1000);

function addFont() {
	if (document.getElementsByClassName('cP')[0]) {
		frame = 'canvas';
		clearInterval(interval);
		addFontLink();
//		addGmailStyle();
	}
	if (document.getElementById('loading')) {
		frame = 'outside';
		clearInterval(interval);
		addFontLink();
//		addGmailStyle();
	}
	count++;
	if (count > 10) {
		clearInterval(interval);
	}
}

function addFontLink() {
	// First, make sure the protocols match
    var gmailProtocol = window.location.protocol;
    
    if (gmailProtocol == 'https:' && font['url'].indexOf('http://') == 0)
    	font['url'] = font['url'].replace('http://', 'https://');
    else if (gmailProtocol == 'http:' && font['url'].indexOf('https://') == 0)
    	font['url'] = font['url'].replace('https://', 'http://');
    
    var node = document.createElement('link');
	node.href = font['url'];
	node.rel = 'stylesheet';
	node.type = 'text/css';

    console.log( "SanSerify: adding new href: " + node );
    document.getElementsByTagName('head')[0].appendChild(node);
}




function changeFont(el) {
	var len = el.length;
        console.log( "SanSerify: changing " + el + " font" );

	for (var i = 0; i < len; i++) {
		var size = parseInt(el[i].style.fontSize, 10);
		if (size <= 16) {
			el[i].style.fontSize = '18px';
		}
		el[i].style.fontFamily = '\'Open Sans\', ubuntu, sans-serif';
            console.log( "SanSerify: new font family is: " + el[i].style.fontFamily );
	}
}

function changeLinks(el) {
	var len = el.length;

	for (var i = 0; i < len; i++) {
		if (el[i].children.length != 0) { continue; }

		el[i].style.textDecoration = 'none';


		el[i].addEventListener('mouseover', function() {
			this.style.textDecoration = 'underline';
			this.style.color = '#ffcc33';
		}, false);

		el[i].addEventListener('mouseout', function() {
			this.style.textDecoration = 'none';
//			this.style.color = '#ccffcc';
		}, false);
	}
}

(function() {

    console.log( "SanSerify: version 2" );

    addFontLink();

	var a = document.getElementsByTagName('a');
	var p = document.getElementsByTagName('p');
	var blockquote = document.getElementsByTagName('blockquote');
	var span = document.getElementsByTagName('span');
	var font = document.getElementsByTagName('font');
	var td = document.getElementsByTagName('td');

	changeFont(a);
	changeFont(blockquote);
	changeFont(p);
	changeFont(span);
//	changeLinks(a);

	changeFont(font);
	changeFont(td);
})();
