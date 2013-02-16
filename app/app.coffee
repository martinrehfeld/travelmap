class @App
  constructor: ->
    @viewport =
      width:  $(window).width()
      height: $(window).height()

  start: ->
    world = new World 'worldmap', @viewport.width, @viewport.height
    Cities.prepare(world.parseLatLon)
    series = Trips.asSeries(world)

    world.draw -> async.series(series)
