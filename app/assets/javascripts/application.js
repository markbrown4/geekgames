//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require games
//= require pong
//= require dash

$body = $("body");

ie = (function() {
	var undef, v = 3,
	div = document.createElement('div'),
	all = div.getElementsByTagName('i');
	while (div.innerHTML = '<!--[if gt IE ' + (++v) + ']><i></i><![endif]-->', all[0]);
  return v > 4 ? v : undef;
}());

// drop downs
var closeDropDown = function() {
  $('html').unbind();
  $('.drop-down').removeClass('open');
}
var dropDownBlur = function(e) {
  if (e.type == 'click') {
    closest = $(e.target).closest('.drop-down');
    if (closest.length == 0) {
      closeDropDown();
      return false;
    }
    else {
      return false;
    }
  }
  else if (e.which == 27) {
    closeDropDown();
    return false;
  }
}
$body.on('click', '.drop-down .trigger', function(e) {
  dd = $(this).closest('.drop-down').toggleClass('open');
  $('html').on('click keyup', dropDownBlur);
  return false;
})