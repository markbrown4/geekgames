//= require jquery
//= require jquery_ujs
//= require bootstrap

document.documentElement.className = document.documentElement.className.replace(/(^|\s)no-js(\s|$)/, '$1$2');
$body = $("body");
ie = (function() {
	var undef, v = 3,
	div = document.createElement('div'),
	all = div.getElementsByTagName('i');
	while (div.innerHTML = '<!--[if gt IE ' + (++v) + ']><i></i><![endif]-->', all[0]);
  return v > 4 ? v : undef;
}());

//$('.dropdown-toggle').dropdown()