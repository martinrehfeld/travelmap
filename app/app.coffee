class @App
  constructor: ->
    @viewport =
      width:  $(window).width()
      height: $(window).height()

  start: ->
    world = new World 'worldmap', @viewport.width, @viewport.height
    Cities.prepare(world.parseLatLon)

    world.draw ->
      rtThfFmo = world.drawRoundTrip Cities.THF, Cities.FMO
      world.drawTrip Cities.BER, Cities['Paris'], ->
        world.repeatRoundTrip rtThfFmo, ->
          world.repeatRoundTrip rtThfFmo, ->
            world.drawTrip Cities.BER, Cities['Rom'], ->
              world.repeatRoundTrip rtThfFmo, ->
                world.repeatRoundTrip rtThfFmo, ->
                  world.drawTrip Cities.BER, Cities['Moskau'], ->
                    world.repeatRoundTrip rtThfFmo, ->
                      fn = ->
                          world.focusWorld ->
                            world.drawTrip Cities.BER, Cities['New York'], ->
                              world.drawTrip Cities.BER, Cities['Rio de Janeiro'], ->
                                world.drawTrip Cities.BER, Cities['Sydney']
                      setTimeout(fn, 5000)
