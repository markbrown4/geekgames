data = []
winningLine = null
colors = ["#fff", "#aaa", "#888", "#444", "#000"]

class window.Mouse extends Game

  init: =>
    @getPaper()
    @path = "M25.143,200c0,0,20,0,40,0s52.856-7.429,45.714-41.714s-8.571-57.143,19.286-67.857s61.429,9.286,89.286,70s11.428,107.857-22.857,125s-24.286,52.856-8.571,69.285s77.143,22.857,111.429-27.143s-39.286-192.857,14.286-224.286s78.571,8.572,80,27.143S405.143,316.856,488,321.143s21.43-94.354,69.286-93.963s29.285-29.127,55.714-29.127s59.286,0,59.286,0"

  reset: ->
    winningLine.attr('stroke': 'black')
    @startPoint.attr({ 'fill':'green' })
    @startPoint.hover(@prepStart, @start)
    
  render: ->
    @deathLine = @paper.path(@path).attr({ 'stroke-width':500, 'stroke': 'white', 'stroke-linecap': 'round' })
    
    @lines = []
    for i in [40,35,30,25,20,15,10]
      @lines.push @paper.path(@path).attr('stroke-width': i, 'stroke': 'white' )
    
    winningLine = @paper.path(@path).attr({ 'stroke-width': 5, 'stroke': 'black' })
    winningLine.hover @blur
    
    @startPoint = @paper.rect(0, 0, 30, 400).attr({ 'fill':'green', 'stroke-width': 0 })
    @startPoint.hover(@prepStart, @start)
    
    @endPoint = @paper.rect(670, 0, 30, 400).attr({ 'fill':'green', 'stroke-width': 0 })

  prepStart: =>
    @startPoint.attr('fill', 'blue')
    @endPoint.hover @win
    @deathLine.hover @lose
    for line in @lines
      line.hover @blur

  blur: (event, x, y)->
    penalty = 8 - this.id
    winningLine.attr('stroke', colors[this.id-1])
    data.push([new Date().getTime(), penalty, x, y].join('|'))

  unbindEvents: =>
    @endPoint.unhover @win
    @deathLine.unhover @lose
    winningLine.unhover @blur
    for line in @lines
      line.unhover @blur

  lose: =>
    @unbindEvents()
    @stop()
    @reset()

  win: =>
    @unbindEvents()
    @data = data.join('*')
    @stop()
    

