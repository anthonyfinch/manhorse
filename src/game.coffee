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
    @mode.update(@dt)

  start: (level, canvas_id) ->
    @mode = new level(@window, canvas_id)
    @tick()
    console.log "started"
  
class Level
	constructor: (window, canvas_id) ->
    @window = window
    @canvas = document.getElementById canvas_id
    @ctx = @initcanvas()
    @setup
  
  initcanvas: () ->
    @canvas.getContext('2d')

	setup: () ->
		console.log "set up"

	update: (dt) ->
		console.log "Mode update" + dt

class Intro extends Level
  setup: () ->
    console.log "Intro set up"

  update: (dt) ->
    @fps = Math.round(1000/dt)
    console.log @fps
    @ctx.save()
    @ctx.fillStyle = "rgb(200, 200, 200)"
    @ctx.font = "Bold 20px Monospace"
    @ctx.fillText("#{@fps} FPS", 10, 20)
    @ctx.restore()

main = new Game
main.start(Intro, 'game')
