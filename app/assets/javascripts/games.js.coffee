class window.Game
  constructor: () ->
    @wrapper = $('.game')
    @score = 0
    @time = 20000

  start: () ->
    @init()
    @addEvents()
    
    @timer = new Date()
    @loop()
  
  loop: =>
    ms = new Date().getTime() - @timer.getTime()
    if ms < @time
      @updateCountdown ms
      @frame()
      setTimeout(@loop, 10)
    else
      @end()

  addEvents: ->
    for event, callback of @events
      @wrapper.bind event, callback

  removeEvents: ->
    @wrapper.unbind()

  updateCountdown: (ms)->
    $('#countdown').html ((@time-ms)/1000).toFixed(2)

  addScore: (points)->
    @score += points
    $('#score').html @score
      
  end: () ->
    @updateCountdown(@time)
    #@submit()

  postUpdate: (data)->
    $.ajax '/games/update',
      type: 'post',
      data: data

  submit: () ->
    $.ajax '/games/submit',
      type: 'post',
      success: ->
        window.location = window.location
      error: ->
        console.log 'aw, Snap!'

  getCanvas: ->
    $canvas = $('#canvas').append('<canvas width="700" height="400">')
    @ctx = $canvas.find('canvas')[0].getContext("2d")
  
  clearCanvas: ->
    @ctx.clearRect(0, 0, 700, 400);

$ ->
  
  $('#play').click ->
    game = new Pong
    game.start()
    
    false