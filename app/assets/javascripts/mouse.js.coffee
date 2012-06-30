data = []
winningLine = null
colors = ["#fff", "#aaa", "#888", "#444", "#000"]
boundaryColors = ["#FF3100", "#0772A1", "#FF8700", "#00B74A"]

class window.Mouse extends Game

  init: =>
    @events = mousemove: @mousemove
    
    @getPaper()
    @path = "M25.143,200c0,0,20,0,40,0s52.856-7.429,45.714-41.714s-8.571-57.143,19.286-67.857s61.429,9.286,89.286,70s11.428,107.857-22.857,125s-24.286,52.856-8.571,69.285s77.143,22.857,111.429-27.143s-39.286-192.857,14.286-224.286s78.571,8.572,80,27.143S405.143,316.856,488,321.143s21.43-94.354,69.286-93.963s29.285-29.127,55.714-29.127s59.286,0,59.286,0"
    @path = "M98.714,199c0,0,85,11.428,72.143-57.143c-12.857-68.571,55-70.714,81.429-17.143s37.857,104.285,21.429,131.428s-48.571,34.286-45,62.857s25,69.285,91.429,30.714S353,251.143,342.286,207.571s-15.714-101.429,22.143-114.286s57.857,7.143,63.571,75s34.285,145.715,72.143,148.572s46.429-21.429,47.857-50s4.999-41.733,30.714-40.51s17.858-33.062,48.572-32.348S658,194.714,658,194.714"
    
    offset = $('#canvas').offset()
    @offsetTop = offset.top + 10
    @offsetLeft = offset.left

    @getCanvas()
    @ctx.strokeStyle = "red"
    @ctx.lineWidth - 2
    @ctx.beginPath();

  reset: ->
    winningLine.attr('stroke': 'black')
    @startPoint.attr({ 'fill':'white' })
    @startPoint.hover(@prepStart, @start)
    
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
    if @playing
      @ctx.lineTo(@pos.x,@pos.y);
      @ctx.stroke();
    @prev = @pos

  lose: =>
    @playing = false
    @unbindEvents()
    $body.addClass("retry show-dialog")

  win: =>
    @playing = false
    @unbindEvents()
    data.push([String(new Date().getTime())])
    @data = data.join('*')
    @stop()

