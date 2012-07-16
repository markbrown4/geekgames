Base64 = (->

  charMap = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
  encode = @btoa || (input) ->
    output = ""
    i = 0
    
    while i < input.length
      chr1 = input.charCodeAt i++
      chr2 = input.charCodeAt i++
      chr3 = input.charCodeAt i++
      enc1 = chr1 >> 2
      enc2 = ((chr1 & 3) << 4) | (chr2 >> 4)
      enc3 = ((chr2 & 15) << 2) | (chr3 >> 6)
      enc4 = chr3 & 63
      
      if isNaN chr2 then enc3 = enc4 = 64
      else if isNaN chr3 then enc4 = 64
      
      for char in [ enc1, enc2, enc3, enc4 ]
        output += charMap.charAt char
    
    output
  
  encode: (input) -> encode unescape( encodeURIComponent input )

)()

class Game

  constructor: ->
    @wrapper = $('.game')
    
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
    @loop()
    
    null

  stop: =>
    $body.removeClass 'playing'
    $body.addClass 'finished show-dialog'
    cancelAnimationFrame(@loop)

  loop: =>
    requestAnimationFrame(@loop)
    
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
    if !@submitted
      @submitted = true
      $.ajax '/games/submit',
        type: 'POST'
        dataType: "json"
        data: { data: Base64.encode(@data) }
        success: (data)->
          window.location = data.redirect_to
        error: ->
          alert('Oh, there was an error with that submission, please try again.')
          window.location = window.location
    
    false

  getCanvas: ->
    canvas = $('#canvas').append('<canvas width="700" height="400"></canvas>').find('canvas')[0]
    if window.G_vmlCanvasManager
      canvas = window.G_vmlCanvasManager.initElement(canvas)
    @ctx = canvas.getContext '2d'

  clearCanvas: ->
    @ctx.clearRect(0, 0, 700, 400);

  getPaper: ->
    @paper = Raphael('canvas', 700, 400);
  
  incrementScore: ->
    $('#score_count').html(Number($('#score_count').html()) + 1)

data = []
winningLine = null
colors = ["#fff", "#aaa", "#888", "#444", "#000"]
boundaryColors = ["#FF3100", "#0772A1", "#FF8700", "#00B74A"]

class Mouse extends Game

  init: =>
    @events = mousemove: @mousemove

    @getPaper()
    @path = "M25.143,200c0,0,20,0,40,0s52.856-7.429,45.714-41.714s-8.571-57.143,19.286-67.857s61.429,9.286,89.286,70s11.428,107.857-22.857,125s-24.286,52.856-8.571,69.285s77.143,22.857,111.429-27.143s-39.286-192.857,14.286-224.286s78.571,8.572,80,27.143S405.143,316.856,488,321.143s21.43-94.354,69.286-93.963s29.285-29.127,55.714-29.127s59.286,0,59.286,0"
    @path = "M98.714,199c0,0,85,11.428,72.143-57.143c-12.857-68.571,55-70.714,81.429-17.143s37.857,104.285,21.429,131.428s-48.571,34.286-45,62.857s25,69.285,91.429,30.714S353,251.143,342.286,207.571s-15.714-101.429,22.143-114.286s57.857,7.143,63.571,75s34.285,145.715,72.143,148.572s46.429-21.429,47.857-50s4.999-41.733,30.714-40.51s17.858-33.062,48.572-32.348S658,194.714,658,194.714"

    offset = $('#canvas').offset()
    @offsetTop = offset.top + 10
    @offsetLeft = offset.left
    
    $('#timer').show()
    
    if not ($.browser.msie || $.browser.opera)
      @getCanvas()
      @ctx.strokeStyle = "red"
      @ctx.lineWidth - 2
      @ctx.beginPath();

  reset: ->
    winningLine.attr('stroke': 'black')
    @startPoint.attr({ 'fill':'white' })
    @startPoint.hover(@prepStart, @start)
  
  frame: ->
    if @playing
      time = (20 - (new Date().getTime() - @start_time) / 1000).toFixed(2)
      if (time < 0)
        time = 0
        @lose true
        $('#timer_count').html('0.00')
      $('#timer_count').html(time)
  
  render: ->
    @deathLine = @paper.path(@path).attr({ 'stroke-width':500, 'stroke': 'white', 'stroke-linecap': 'round' })

    @lines = []
    for i,j in [45,35,25,15]
      @lines.push @paper.path(@path).attr('stroke-width': i, 'stroke': 'white' )

    winningLine = @paper.path(@path).attr({ 'stroke-width': 5, 'stroke': 'black' })
    winningLine.hover @blur

    @startPoint = @paper.image("/assets/start.png", 27, 183, 82, 31);
    @endPoint = @paper.image("/assets/finish.png", 642, 153, 30, 76);

  onStart: =>
    data = []
    data.push([String(new Date().getTime())])
    @startPoint.mouseout(@prepStart, @start)
    
    @start_time = new Date().getTime()

  prepStart: =>
    @playing = true
    @endPoint.hover @win
    @deathLine.hover @lose
    for line in @lines
      line.hover @blur

  blur: (event, x, y)->
    penalty = 6 - this.id
    winningLine.attr('stroke', colors[this.id-1])
    data.push([new Date().getTime(), penalty, x, y].join('|'))

  unbindEvents: =>
    @endPoint.unhover @win
    @deathLine.unhover @lose
    winningLine.unhover @blur
    for line in @lines
      line.unhover @blur

  mousemove: (e) =>
    @pos = x: Math.floor(e.pageX - @offsetLeft), y: Math.floor(e.pageY - @offsetTop)
    if @playing && @ctx
      @ctx.lineTo(@pos.x,@pos.y);
      @ctx.stroke();
    @prev = @pos

  lose: (reallyLose = false)=>
    # Double check
    if !reallyLose && @lines[0].isPointInside(@pos.x, @pos.y)
      return
    
    @playing = false
    @unbindEvents()
    $body.addClass("retry show-dialog")

  win: =>
    @playing = false
    @unbindEvents()
    data.push([String(new Date().getTime())])
    @data = data.join('*')
    @stop()

class Shoot extends Game
  init: ->
    @events = mousedown: @mousedown

    @getCanvas()
    @ctx.fillStyle = 'red'
    @ySpeeds = [.2,.1,0,-.1,-.2]
    @xSpeeds = [.2,.4,.6]
    @fireRate = 1000
    @objects = []
    @lives = 5

    @objWidth = 70
    @objHeight = 63
    offset = $('#canvas').offset()
    @offsetTop = offset.top + 10
    @offsetLeft = offset.left

    @email = new Image()
    @email.src = '/assets/email.png'
    @spam = new Image()
    @spam.src = '/assets/spam.png'

    $('#score').show()

  onStart: -> data.push([String(new Date().getTime())])

  push: ->
    @objects.push
      x: 0 - @objWidth
      y: Math.floor(Math.random()*300)
      xSpeed: @xSpeeds[Math.floor(Math.random()*@xSpeeds.length)]
      ySpeed: @ySpeeds[Math.floor(Math.random()*@ySpeeds.length)]
      drEvil: if Math.random() > .8 then true else false

  pushLoop: ->
    setTimeout =>
      @push()
      @pushLoop()
    , @fireRate

    if @fireRate > 50
      @fireRate -= 10

  onStart: ->
    @pushLoop()

  mousedown: (e)=>
    @pos = x: Math.floor(e.pageX - @offsetLeft), y: Math.floor(e.pageY - @offsetTop)

  frame: (ms)=>
    if @lives < 1
      @finish()
      return
    for object, i in @objects
      if object
        # boundaries
        if (object.y < 0 && object.ySpeed < 0) || (object.y > 400-@objHeight && object.ySpeed > 0)
          object.ySpeed = (0- object.ySpeed)

        object.x = Math.floor(object.x + object.xSpeed * ms)
        object.y = Math.floor(object.y + object.ySpeed * ms)

        # hit detect
        if @pos && object.x > 0 && (@pos.x > object.x && @pos.x < object.x + @objWidth) && (@pos.y > object.y && @pos.y < object.y + @objHeight)
          if !object.drEvil
            @lives--
          evil = if object.drEvil then 1 else 0
          if (object.drEvil)
            @incrementScore()
          data.push([new Date().getTime(), evil, object.x, object.y].join('|'))
          @objects.splice(i,1)
        else if object.x > 700 # miss detect
          if object.drEvil
            @lives--
          data.push([new Date().getTime(), evil, object.x, object.y].join('|'))
          @objects.splice(i,1)

    @pos = null
    @render()

  render: =>
    @clearCanvas()
    if @objects.length > 0
      for object in @objects
        @image = if object.drEvil then @spam else @email
        @ctx.drawImage @image, object.x, object.y, @objWidth, @objHeight

  finish: =>
    unless @finished
      @finished = true
      data.push([String(new Date().getTime())])
      @data = data.join('*')
      @stop()

class Pong extends Game

  init: ->
    @events = keydown: @keydown, keyup: @keyup

    @getCanvas()
    @ctx.fillStyle = 'red'
    @lives = 5
    @ai = paddle: new Image()
    @player = paddle: new Image()
    @player.paddle.src = '/assets/paddle.png'
    @ai.paddle.src = '/assets/paddle-ai.png'
    @player.y = 160
    @ai.y = 160

    @ySpeeds = [-6, -2, 2, 6]

    @reset()

  onStart: -> data.push([String(new Date().getTime())])

  reset: ->
    @player.ySpeed = 0
    @player.y = 160
    @ai.y = 160
    @ball = x: 350, y: 200, xSpeed: 6
    @ballSpeed = .08
    @paddleSpeed = 8
    @ball.ySpeed = @ySpeeds[Math.floor(Math.random()*@ySpeeds.length)]

    $('#score').show()

  frame: (ms)=>
    distance = ms * @ballSpeed
    # player movement
    if @player.ySpeed != 0
      @player.y -= @player.ySpeed
      if @player.y < 0
        @player.y = 0
      else if @player.y > 320
        @player.y = 320

    # ai movement - what a bastard.
    @ai.y = @ball.y - 40

    # boundaries
    if !@missed
      if (@ball.y < 10 && @ball.ySpeed < 0)
        @ball.y = 10
        @ball.ySpeed = (0 - @ball.ySpeed)
      if (@ball.y > 390 && @ball.ySpeed > 0)
        @ball.y = 390
        @ball.ySpeed = (0 - @ball.ySpeed)
        
      if @ball.x < 60 && @ball.xSpeed < 0
        diff = @ball.y - @player.y
        data.push([new Date().getTime(), diff, @ball.x, @ball.y].join('|'))
        if diff < 0 || diff > 80 # missed paddle
          @inTheNet()
        else # bounced off paddle
          @incrementScore()
          @ball.ySpeed = @ySpeeds[Math.floor(diff / 20)]
          @ball.xSpeed = (0 - @ball.xSpeed)
      else if @ball.x > 640 && @ball.xSpeed > 0
        @ballSpeed += .005
        @ball.xSpeed = (0 - @ball.xSpeed)

    @ball.x += Math.floor(@ball.xSpeed * distance)
    @ball.y += Math.floor(@ball.ySpeed * distance)

    @render()

  inTheNet: ->
    @missed = true
    @lives--;
    if (@lives > 0)
      setTimeout =>
        @missed = false
        @reset()
      , 300
    else
      @finish()

  render: ->
    @clearCanvas()

    @ctx.drawImage @player.paddle, 20, @player.y, 30, 80
    @ctx.drawImage @ai.paddle, 650, @ai.y, 30, 80

    @ctx.beginPath()
    @ctx.arc @ball.x, @ball.y, 10, 0, Math.PI*2 ,true
    @ctx.fill()

  keydown: (e) =>
    if e.which == 38
      @player.ySpeed = @paddleSpeed
    else if e.which == 40
      @player.ySpeed = (0-@paddleSpeed)

    false

  keyup: (e)=>
    @player.ySpeed = 0

    false

  finish: =>
    unless @finished
      @finished = true
      data.push([String(new Date().getTime())])
      @data = data.join('*')
      @stop()

$ ->
  
  $body.keydown (e)->
    if (e.which == 27)
      $body.removeClass('finished show-dialog show-deal show-main-prize playing retry')
  
  if $body.hasClass('games')
    game = null

    if ($body.hasClass('game-1'))
      game = new Mouse()
    else if ($body.hasClass('game-2'))
      game = new Shoot()
    else if ($body.hasClass('game-3'))
      game = new Pong()
    else
      return
  
    $('#play, #instructions').click game.countdown
    $("#submit").click game.submit
    $('#retry').click -> window.location = window.location
  