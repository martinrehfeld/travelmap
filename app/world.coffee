class @World
  constructor: (el, @width, @height) ->
    @canvas = Raphael el, @width, @height

  draw: ->
    r = @canvas

    # background
    r.rect(0, 0, @width, @height).attr(
      stroke: 'none',
      fill: '0-#f8d59b-#e8ad5d'
    )

    # country shapes
    r.setStart()
    for own _, shape of worldmap.shapes
      do (shape) ->
        r.path(shape).attr(stroke: '#a23105', fill: '#b35317', 'stroke-opacity': 0.5)
    world = r.setFinish()

    # demonstrate the use of parseLatLon for marking a position by geo coords
    @dot = @canvas.circle().attr(fill: "r#FE7727:50-#F57124:100", stroke: "#fff", "stroke-width": 2, r: 0)
    @setMarker('33°51′35.9″S, 151°12′40″E') # Sydney

    # initial viewport
    @focusEurope()

  focusEurope: =>
    aspectRatio = @width / @height
    newHeight = 85
    newWidth = newHeight * aspectRatio
    @canvas.setViewBox(400, 50, newWidth, newHeight, false)

  focusWorld: =>
    anim = new ViewBoxAnimation(@canvas, 1500, x: 0, y: 0, w: 1000, h: 400)
    setTimeout(anim.execute, 0)

  setMarker: (humanCoords) ->
    attr = @parseLatLon(humanCoords)
    attr.r = 0
    @dot.stop().attr(attr).animate({r:5}, 1000, 'elastic')

  getXY: (lat, lon) ->
    cx: lon * 2.6938 + 465.4,
    cy: lat * -2.6938 + 227.066

  getLatLon: (x, y) ->
    lat: (y - 227.066) / -2.6938,
    lon: (x - 465.4) / 2.6938

  latlonrg: /(\d+(?:\.\d+)?)[\xb0\s]?\s*(?:(\d+(?:\.\d+)?)['\u2019\u2032\s])?\s*(?:(\d+(?:\.\d+)?)["\u201d\u2033\s])?\s*([SNEW])?/i

  parseLatLon: (latlon) ->
    m = String(latlon).split(@latlonrg)
    lat = m && +m[1] + (m[2] || 0) / 60 + (m[3] || 0) / 3600
    lat = -lat if m[4].toUpperCase() == "S"
    lon = m && +m[6] + (m[7] || 0) / 60 + (m[8] || 0) / 3600
    lon = -lon if m[9].toUpperCase() == "W"
    @getXY(lat, lon)


class ViewBoxAnimation
  constructor: (canvas, duration, finalViewBox) ->
    @duration = duration
    @canvas = canvas
    @finalViewBox = finalViewBox
    [@x, @y, @w, @h] = canvas._viewBox

  execute: =>
    @startTime = new Date().getTime()
    @endTime = @startTime + @duration
    window.requestAnimationFrame(@animate)

  animate: =>
    now = new Date().getTime()
    completeness = if now >= @endTime then 1 else (now - @startTime) / @duration

    @canvas.setViewBox(@x + ((@finalViewBox.x - @x) * completeness),
                       @y + ((@finalViewBox.y - @y) * completeness),
                       @w + ((@finalViewBox.w - @w) * completeness),
                       @h + ((@finalViewBox.h - @h) * completeness),
                       false)

    window.requestAnimationFrame(@animate) if completeness != 1
