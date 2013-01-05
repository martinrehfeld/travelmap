class @App
  constructor: ->
    @viewport =
      width:  $(window).width()
      height: $(window).height()

  start: ->
    world = new World 'worldmap', @viewport.width, @viewport.height
    world.draw()
    world.drawTrip '52 30 N 13 25 E', '48 48 N 2 20 E', ->
      world.drawTrip '52 30 N 13 25 E', '41 54 N 12 27 E', ->
        world.focusWorld ->
          world.drawTrip '52 30 N 13 25 E', '40 47 N 73 58 W', ->
            world.drawTrip '52 30 N 13 25 E', '22 57 S 43 12 W', ->
              world.drawTrip '52 30 N 13 25 E', '34 0 S 151 0 E'
