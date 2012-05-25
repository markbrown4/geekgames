class window.Dash extends Game

  init: =>
    @events = mousemove: @mousemove
  
  mousemove: (e)->
    pos = x: e.pageX - this.offsetLeft, y: e.pageY - this.offsetTop
    console.log pos
    
    false