$('.open-deal').click ->
  $body.addClass('show-deal show-dialog')
  lastOption = $('input:radio[name=prize]').last()
  lastOption.attr('checked', 'checked');
  $('#buy-now').attr('href', lastOption.val())
  
  false
  
$('#view-main-prize').click ->
  $body.addClass('show-main-prize show-dialog')
  
  false

$('.close').click ->
  $body.removeClass('show-deal show-main-prize show-dialog')
  
  false

$('input:radio[name=prize]').change ->
  $('#buy-now').attr('href', $(this).val())

