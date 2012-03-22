# Here we are in the file then.

class Game
  constructor: () ->
    @window = window
    @animFrame = window.requestAnimationFrame ||
    	window.webkitRequestAnimationFrame ||
    	window.mozRequestAnimationFrame    ||
    	window.oRequestAnimationFrame      ||
    	window.msRequestAnimationFrame     ||
    	null
  
  tick: (dothis) ->
    @animFrame.call(@window, dothis)

  update: () =>
    @tick(@update)
    console.log "update"

  start: () ->
    @tick(@update)
    console.log "started"

class Mode
	constructor: (window) ->
		@window = window

	update: () ->
		console.log "Mode update"

main = new Game
main.start()
