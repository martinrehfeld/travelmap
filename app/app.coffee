class @App
  constructor: ->
    @viewport =
      width:  $(window).width()
      height: $(window).height()

  start: ->
    world = new World 'worldmap', @viewport.width, @viewport.height
    world.draw()
    world.focusWorld()

