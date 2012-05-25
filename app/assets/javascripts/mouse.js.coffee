class Mouse extends Game

  init: ->
    @events = click: @click

  click: (e)->
    pos = x: e.pageX - this.offsetLeft, y: e.pageY - this.offsetTop
    console.log pos

    false