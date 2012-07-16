//= require jquery
//= require jquery_ujs
//= require raphael

//= require requestAnimFrame
//= require games
//= require deals

// window.onerror = function(message, file, line) {
//   $.ajax({
//     type: 'POST',
//     url: '/errors',
//     data: JSON.stringify({
//       error: {
//         user_agent: JSON.stringify($.browser),
//         message: message,
//         file: file.split("/").slice(3).join("/"),
//         line: line
//       }
//     }),
//     contentType: 'application/json; charset=utf-8'
//   }); 
// }

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
