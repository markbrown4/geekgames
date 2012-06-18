data = []

class window.Shoot extends Game
  init: ->
    @events = mousedown: @mousedown
    
    @getCanvas()
    @ctx.fillStyle = 'red'
    @ySpeeds = [.2,.1,0,-.1,-.2]
    @xSpeeds = [.2,.4,.6]
    @fireRate = 1000
    @objects = []
    @lives = 5

    @objWidth = 50
    @objHeight = 30
    offset = $('#canvas').offset()
    @offsetTop = offset.top + 10
    @offsetLeft = offset.left

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
    if @lives == 0
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
        @ctx.beginPath()
        @ctx.fillStyle = if object.drEvil then 'red' else 'green'
        @ctx.rect(object.x, object.y, @objWidth, @objHeight)
        @ctx.fill()

  offScreen: (object)->
    # console.log object

  finish: =>
    @data = data.join('*')
    @stop()
  