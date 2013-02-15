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
      async.series([
        (cb) -> world.drawTrip Cities.BER, Cities['Paris'], -> cb(null),
        (cb) -> world.repeatRoundTrip rtThfFmo, -> cb(null),
        (cb) -> world.repeatRoundTrip rtThfFmo, -> cb(null),
        (cb) -> world.drawTrip Cities.BER, Cities['Rom'], -> cb(null),
        (cb) -> world.repeatRoundTrip rtThfFmo, -> cb(null),
        (cb) -> world.repeatRoundTrip rtThfFmo, -> cb(null),
        (cb) -> world.drawTrip Cities.BER, Cities['Moskau'], -> cb(null),
        (cb) -> world.repeatRoundTrip rtThfFmo, -> cb(null),
        (cb) -> setTimeout((-> cb(null)), 5000),
        (cb) -> world.focusWorld -> cb(null),
        (cb) -> world.drawTrip Cities.BER, Cities['New York'], -> cb(null),
        (cb) -> world.drawTrip Cities.BER, Cities['Rio de Janeiro'], -> cb(null),
        (cb) -> world.drawTrip Cities.BER, Cities['Sydney'], -> cb(null)
      ])
