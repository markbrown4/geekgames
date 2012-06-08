class window.Dash extends Game

  init: =>
    @events = mousemove: @mousemove
    @svgPoints = '46.75,192.333 103.001,192.333 103.001,285.666 204.334,285.666,204.334,106.333 401.001,106.333 401.001,244.333 621.001,244.333 621.001,200.5 655,200.5 655,203.666 624.334,203.666,624.334,248.999 397.001,248.999 397.001,110.999 207.667,110.999 207.667,289.666 99.667,289.666 99.667,196.333 46.75,196.333'
    @map = [
      [30,200],
      [155,200],
      [155,290],
      [260,290],
      [260,110],
      [450,110],
      [450,250],
      [610,250],
      [610,200],
      [670,200]
    ]
    # -2 ----
    # -1 ----
    #  0 ----
    # -1 ----
    # -2 ----
    
    @getCanvas()
    @offset = $('canvas').offset()
    @render()
  
  mousemove: (e)=>
    pos = x: e.pageX - @offset.left, y: e.pageY - @offset.top
    @render(pos)
    
    false
    
  render: (pos = x: 0, y: 0)->
    @ctx.beginPath()
    @ctx.moveTo(@map[0][0],@map[0][1]);
    for point,i in @map
      
      # width = if i%2 == 0 then @map[i+1][0] = point[0]  #horizontal
      #       height = if i%2 == 1 then @map[i+1][0] = point[0]
      #       nextPoint = @map[i+1]
      
      @ctx.lineTo(point[0],point[1]);
      #@ctx.rect(point[0],point[1],nextPoint[0],point[1]);
    @ctx.lineWidth = 3
    @ctx.strokeStyle = 'black'
    if @ctx.isPointInPath(pos.x,pos.y)
      @ctx.strokeStyle = 'red';
    @ctx.stroke()

  frame: ->
    
