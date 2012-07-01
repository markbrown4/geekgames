//= require jquery
//= require jquery_ujs
//= require raphael

//= require games
//= require deals

$body = $("body");

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
