class @App
  constructor: ->
    @viewport =
      width:  $(window).width()
      height: $(window).height()

  start: ->
    (new World 'worldmap', @viewport.width, @viewport.height).draw()
