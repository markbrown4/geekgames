class Game
  constructor: () ->
    @score = 0
    
  submit: () ->
    $.ajax '/rounds/submit',
      type: 'post',
      data:
        score: @score
      success: ->
        window.location = window.location
      error: ->
        console.log 'aw, Snap!'

$ ->

  window.game = new Game
  
  $('#play').click ->
    game.score = 50
    game.submit()
    
    false