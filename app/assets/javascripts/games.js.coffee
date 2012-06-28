class window.Game

  constructor: ->
    @wrapper = $('.game')
    @frameRate = 10
    
    @init()
    @addEvents()
    @render()
  
  countdown: =>
    $('#instructions').hide()
    $body.addClass('counting');
    $countdown = $('#countdown')
    $countdown.html 3
    setTimeout ->
      $countdown.html 2
    , 1000
    setTimeout ->
      $countdown.html 1
    , 2000
    setTimeout =>
      $body.removeClass('counting');
      $countdown.html "GO!"
      @start()
    , 3000
    
    false

  start: =>
    @onStart() if @onStart
    $body.addClass('playing');
    @prev = @startTime = new Date().getTime()
    @timer = setInterval(@loop, @frameRate)
    null

  stop: ->
    $body.removeClass 'playing'
    $body.addClass 'finished'
    
    clearInterval @timer

  loop: =>
    now = new Date().getTime()
    ms = now - @prev
    @prev = now
    
    @frame(ms) if @frame

  addEvents: =>
    for event, callback of @events
      $body.on event, callback

  removeEvents: ->
    $body.unbind()

  submit: =>
    # console.log @data
    # console.log @munge(@data, 5)
    
    url = if (@constructor.name == 'Pong') then "/rounds/summary" else window.location
    $.ajax '/games/submit',
      type: 'POST'
      dataType: "json"
      data: @data
      success: -> window.location = url
      error: -> window.location = url
    
    false

  getCanvas: ->
    $canvas = $('#canvas').append('<canvas width="700" height="400">')
    @ctx = $canvas.find('canvas')[0].getContext("2d")

  clearCanvas: ->
    @ctx.clearRect(0, 0, 700, 400);

  getPaper: ->
    @paper = Raphael('canvas', 700, 400);
  
  munge: (text, key)->
    result = "";
    for i in [0..text.length]
      result += String.fromCharCode(key^text.charCodeAt(i))
    result

$ ->
  
  $body.keydown (e)->
    if (e.which == 27)
      $body.removeClass('finished')
  $(".close").click ->
    $body.removeClass('finished')
    
    false
  
  
    
  if $body.hasClass('games')
    window.game = null
    if ($body.hasClass('game-1'))
      window.game = new Mouse()
    else if ($body.hasClass('game-2'))
      window.game = new Shoot()
    else if ($body.hasClass('game-3'))
      window.game = new Pong()
    else
      return
  
    $('#play, #instructions').click game.countdown
    $("#submit").click game.submit
  