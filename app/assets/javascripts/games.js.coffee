class Game
  constructor: () ->
    @wrapper = $('.game')
    
    @score = 0
    @time = 20000
    

  start: () ->
    @init()
    @addEvents()
    
    @timer = new Date()
    setTimeout =>
      ms = new Date().getTime() - @timer.getTime()
      if ms < @time
        @updateCountdown ms
        setTimeout(arguments.callee, 10)
      else
       @end()
    , 10
      
  addEvents: ->
    for event, callback of @events
      @wrapper.bind event, callback

  removeEvents: ->
    @wrapper.unbind()

  updateCountdown: (ms)->
    $('#countdown').html ((@time-ms)/1000).toFixed(2)

  end: () ->
    updateCountdown(@time)
    #@submit()

  postUpdate: (data)->
    $.ajax '/games/update',
      type: 'post',
      data: data

  submit: () ->
    $.ajax '/games/submit',
      type: 'post',
      success: ->
        window.location = window.location
      error: ->
        console.log 'aw, Snap!'

class Pong extends Game
  
  init: ->
    @events = keydown: @keydown
    @speed = 20
    
  keydown: (e)->
    console.log e.which
    if e.which == 38
      console.log 'up'
    else if e.which == 40
      console.log 'down'
    
    false

class Dash extends Game

  init: =>
    @events = mousemove: @mousemove
  
  mousemove: (e)->
    pos = x: e.pageX - this.offsetLeft, y: e.pageY - this.offsetTop
    console.log pos
    
    false

class Mouse extends Game

  init: ->
    @events = click: @click

  click: (e)->
    pos = x: e.pageX - this.offsetLeft, y: e.pageY - this.offsetTop
    console.log pos

    false
$ ->

  window.game = new Pong
  #window.game = new Dash
  #window.game = new Mouse
  
  $('#play').click ->
    game.start()
    
    false