$('.open-deal').click ->
  $body.addClass('show-deal show-dialog')
  
  false

$('#close_deal').click ->
  $body.removeClass('show-deal show-dialog')
  
  false

$('input:radio[name=prize]').change ->
  $('#buy-now').attr('href', $(this).val())
