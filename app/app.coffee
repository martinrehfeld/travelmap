class @App
  constructor: ->
    @viewport =
      width:  $(window).width()
      height: $(window).height()

  start: ->
    world = new World 'worldmap', @viewport.width, @viewport.height
    Cities.prepare(world.parseLatLon)
    world.draw()

    world.drawTrip Cities.THF, Cities.FMO, ->
      world.drawTrip Cities.BER, Cities['Paris'], ->
        world.drawTrip Cities.BER, Cities['Rom'], ->
          world.focusWorld ->
            world.drawTrip Cities.BER, Cities['New York'], ->
              world.drawTrip Cities.BER, Cities['Rio de Janeiro'], ->
                world.drawTrip Cities.BER, Cities['Sydney']
