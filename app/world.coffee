class @World
  @latlonrg = /(\d+(?:\.\d+)?)[\xb0\s]?\s*(?:(\d+(?:\.\d+)?)['\u2019\u2032\s])?\s*(?:(\d+(?:\.\d+)?)["\u201d\u2033\s])?\s*([SNEW])?/i
  @rtInitialStroke = '#a90606'
  @rtInitialStrokeWidth = 4

  _roundtrips: {}
  _countries: {}

  constructor: (el, @width, @height) ->
    @canvas = Raphael el, @width, @height

  draw: (callback) ->
    r = @canvas

    # background
    r.rect(0, 0, @width, @height).attr
      stroke: 'none',
      fill: 'url("/images/mapbackground.jpg")'
      'fill-opacity': 0.75

    # country shapes
    r.setStart()
    for own countryCode, shape of worldmap.shapes
      do (shape) =>
        path = r.path(shape).attr
                 stroke: '#a23105'
                 fill: '#b35317'
                 'fill-opacity': 0.75
                 'stroke-opacity': 0.5
        @_countries[countryCode] = path
    world = r.setFinish()

    # initial viewport
    @focusEurope()

    setTimeout(callback, 1000)

  focusEurope: =>
    aspectRatio = @width / @height
    newHeight = 85
    newWidth = newHeight * aspectRatio
    @canvas.setViewBox(400, 50, newWidth, newHeight, false)

  focusWorld: (callback) =>
    callback ?= ->
    anim = new ViewBoxAnimation(@canvas, 1500, x: 0, y: 0, w: 1000, h: 400)
    setTimeout((=> anim.execute(callback)), 0)

  drawRoundTrip: (from, to) ->
    p1 =
      cx: from.cx + (to.cx - from.cx) / 2
      cy: from.cy + (to.cy - from.cy) / 2 + (to.cx - from.cx) * 0.3
    p2 =
      cx: from.cx + (to.cx - from.cx) / 2
      cy: from.cy + (to.cy - from.cy) / 2 - (to.cx - from.cx) * 0.3

    path = @canvas.path("M#{from.cx},#{from.cy}
                         Q#{p1.cx},#{p1.cy},#{to.cx},#{to.cy}
                         Q#{p2.cx},#{p2.cy},#{from.cx},#{from.cy}
                         Z")
                  .attr
                    stroke: World.rtInitialStroke
                    'stroke-width': World.rtInitialStrokeWidth
    image = @canvas.image('/images/roundtrip.png', p1.cx-3, p1.cy+1.7, 6, 6)

    ref = "#{from.key}-#{to.key}"
    rgb = Raphael.getRGB(World.rtInitialStroke)
    @_roundtrips[ref] =
      trips: 1
      color: Raphael.rgb2hsl(rgb.r, rgb.g, rgb.b)
      strokeWidth: World.rtInitialStrokeWidth
      path: path
      image: image
    ref

  repeatRoundTrip: (ref, callback) =>
    callback ?= ->
    rt = @_roundtrips[ref]
    @intensifyRoundtrip(rt)
    rt.image.toFront()
    rt.path.animate { 'stroke-width': rt.strokeWidth
                    , stroke: rt.color.toString()
                    },
                    500, 'linear', =>
                      callback()

  intensifyRoundtrip: (rt) ->
    rt.strokeWidth += 1 if rt.trips < 10
    rt.color.s *= 1.05
    rt.color.s = 1 if rt.color.s > 1
    rt.color.l *= 1.05
    rt.color.l = 1 if rt.color.l > 1
    rt.trips += 1

  drawTrip: (from, to, callback) =>
    callback ?= ->

    # highlight destination country
    setTimeout((=> @_countries[to.country].attr(fill: '#a23105', 'fill-opacity': 0.5)), 500)

    p1 =
      cx: from.cx + (to.cx - from.cx) / 2
      cy: from.cy + (to.cy - from.cy) / 2 - Math.abs(to.cx - from.cx) * 0.1
    path = @canvas.path("M#{from.cx},#{from.cy}")
                  .attr
                    stroke: '#a90606'
                    'stroke-width': 6
                    'stroke-linecap': 'round'
                    # 'stroke-dasharray': '.'
    path.animate {path: "M#{from.cx},#{from.cy}
                         Q#{p1.cx},#{p1.cy},#{to.cx},#{to.cy}"},
                 500, 'linear', =>
                   path.attr 'arrow-end': 'diamond-narrow-short'
                   callback()

  getXY: (lat, lon) ->
    cx: lon * 2.6938 + 465.4,
    cy: lat * -2.6938 + 227.066

  getLatLon: (x, y) ->
    lat: (y - 227.066) / -2.6938,
    lon: (x - 465.4) / 2.6938

  parseLatLon: (latlon) =>
    m = String(latlon).split(World.latlonrg)
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

  execute: (callback) =>
    @startTime = new Date().getTime()
    @endTime = @startTime + @duration
    window.requestAnimationFrame(=> @animate(callback))

  animate: (callback) =>
    now = new Date().getTime()
    completeness = if now >= @endTime then 1 else (now - @startTime) / @duration

    @canvas.setViewBox(@x + ((@finalViewBox.x - @x) * completeness),
                       @y + ((@finalViewBox.y - @y) * completeness),
                       @w + ((@finalViewBox.w - @w) * completeness),
                       @h + ((@finalViewBox.h - @h) * completeness),
                       false)

    if completeness == 1
      callback()
    else
      window.requestAnimationFrame(=> @animate(callback))
