data = []
class window.Pong extends Game
  
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

  onStart: -> data.push(new Date().getTime())

  reset: ->
    @player.ySpeed = 0
    @player.y = 160
    @ai.y = 160
    @ball = x: 350, y: 200, xSpeed: 6
    @ballSpeed = .08
    @paddleSpeed = 8
    @ball.ySpeed = @ySpeeds[Math.floor(Math.random()*@ySpeeds.length)]
    
    
    $('#lives_count').html(@lives)
    $('#lives').show()
    
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
      if (@ball.y < 10 && @ball.ySpeed < 0) || (@ball.y > 390 && @ball.ySpeed > 0)
        @ball.ySpeed = (0 - @ball.ySpeed)
      if @ball.x < 60 && @ball.xSpeed < 0
        diff = @ball.y - @player.y
        data.push([new Date().getTime(), diff, @ball.x, @ball.y].join('|'))
        if diff < 0 || diff > 80 # missed paddle
          @inTheNet()
        else # bounced off paddle
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
    $('#lives_count').html @lives

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
    data.push(new Date().getTime())
    @data = data.join('*')
    @stop()
