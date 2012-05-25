class window.Pong extends Game
  
  init: ->
    @events = keydown: @keydown, keyup: @keyup
    
    @getCanvas()
    @ctx.fillStyle = 'white'
    
    @ai = paddle: new Image()
    @player = paddle: new Image()
    @player.paddle.src = '/assets/paddle.png'
    @ai.paddle.src = '/assets/paddle-ai.png'
    
    @yMoves = [-6, -2, 2, 6]
    
    @reset()
    
  reset: ->
    @player.yMove = 0
    @player.y = 180
    @ai.y = 180
    @ball = x: 350, y: 200, xMove: 6
    
    @ball.yMove = @yMoves[Math.floor(Math.random()*@yMoves.length)]
    
  frame: =>
    # player movement
    if @player.yMove != 0
      @player.y -= @player.yMove
      if @player.y < 0
        @player.y = 0
      else if @player.y > 320
        @player.y = 320
    
    # ai movement - what a bastard.
    @ai.y = @ball.y - 40
    
    # boundaries
    if !@missed
      if @ball.y < 30 || @ball.y > 370
        @ball.yMove = 0 - @ball.yMove
      if @ball.x < 60
        diff = @ball.y - @player.y
        if diff < 0 || diff > 80
          @inTheNet()
        else
          @ball.yMove = @yMoves[Math.floor(diff / 20)]
          @ball.xMove = 0 - @ball.xMove
      else if @ball.x > 640
        @ball.xMove = 0 - @ball.xMove

    @ball.x += @ball.xMove
    @ball.y += @ball.yMove
            
    @render()
  
  inTheNet: ->
    @missed = true
    setTimeout =>
      @missed = false
      @addScore(1)
      @reset()
    , 300
  
  render: ->
    @clearCanvas()

    @ctx.drawImage(@player.paddle, 20, @player.y, 30, 80)
    @ctx.drawImage(@ai.paddle, 650, @ai.y, 30, 80)
    
    @ctx.beginPath()
    @ctx.arc(@ball.x,@ball.y,10,0,Math.PI*2,true);
    @ctx.fill()

  keydown: (e) =>
    if e.which == 38
      @player.yMove = 5
    else if e.which == 40
      @player.yMove = -5
    
    false
  
  keyup: (e)=>
    @player.yMove = 0
    
    false
    