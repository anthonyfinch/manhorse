# Here we are in the file then.

class Game
  constructor: () ->
    @t1 = @t2 = Date.now()
    @dt = 0
    @window = window
    @animFrame = window.requestAnimationFrame ||
    	window.webkitRequestAnimationFrame ||
    	window.mozRequestAnimationFrame    ||
    	window.oRequestAnimationFrame      ||
    	window.msRequestAnimationFrame     ||
    	null
  
  tick: () =>
    @t2 = Date.now()
    @dt = @t2  - @t1
    @t1 = @t2
    @update()
    @animFrame.call(@window, @tick)

  update: () =>
    @level.update(@dt)

  start: (level, canvas_id) ->
    @level = new level(@window, canvas_id)
    @tick()
    console.log "started"
  
class Eventer
  @_listeners = {}

  addListener: (type, listener) ->
    if @_listeners[type]?
      @_listeners[type] = []

    @_listeners[type].push(listener)

  trigger: (event) ->
    if typeof event "string"
      event = { type: event }
    if not event.target
      event.target = this
    if @_listeners[event.type] instanceOf Array
      listeners = @_listeners[event.type]
      listener.call(this, event) for listener in listeners

   removeListener: (type, listener) ->
     if @_listeners[type] instanceOf Array
       listeners = @_listeners[type]
       for key, listener_in in listeners
         if listener_in listener
           listeners[key...key+1]

class Level extends Eventer
	constructor: (window, canvas_id) ->
    @window = window
    @canvas = document.getElementById canvas_id
    @ctx = @initcanvas()
    @setup()
  
  initcanvas: () ->
    @canvas.getContext('2d')

	setup: () ->
		console.log "set up"

	update: (dt) ->
		console.log "Mode update" + dt

class Intro extends Level
  setup: () ->
    @map = new Map(intro_layout)
    console.log "Intro set up"

  update: (dt) ->
    @fps = Math.round(1000/dt)
    @ctx.clearRect(0, 0, 200, 200)
    @ctx.font = "Bold 20px Monospace"
    @ctx.fillText("#{@fps} FPS", 10, 20)

intro_layout = {
  tiles: [
    [a] = "../images/sprite1.png"
  ]
  layout: [
    [a,a,a,a,a,a],
    [a,a,a,a,a,a]
  ]
}

class Map
  constructor: (layout)->
    @layout = layout
    @load()

  load: () ->
    @tiles = @layout.tiles
    console.log 'Loading Tile Images'
    for key, imgSrc in @tiles
      console.log 'Loading tile ' + key + 'src = ' + imgSrc

main = new Game
main.start(Intro, 'game')
