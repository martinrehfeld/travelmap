class @World

  constructor: ->

  draw: ->
    Raphael 10, 10, 1000, 400, ->
      r = @
      r.rect(0, 0, 1000, 400, 10).attr(
        stroke: "none",
        fill: "0-#9bb7cb-#adc8da"
      )

      r.setStart()
      for own _, shape of worldmap.shapes
        do (shape) ->
          r.path(shape).attr(stroke: "#ccc6ae", fill: "#f0efeb", "stroke-opacity": 0.25)
      world = r.setFinish()

      over = ->
        @.c = @.c || @.attr("fill")
        @.stop().animate({fill: "#bacabd"}, 500)
      out = ->
        @.stop().animate({fill: @.c}, 500)
      world.hover(over, out)

      world.getXY = (lat, lon) ->
        cx: lon * 2.6938 + 465.4,
        cy: lat * -2.6938 + 227.066

      world.getLatLon = (x, y) ->
        lat: (y - 227.066) / -2.6938,
        lon: (x - 465.4) / 2.6938

      latlonrg = /(\d+(?:\.\d+)?)[\xb0\s]?\s*(?:(\d+(?:\.\d+)?)['\u2019\u2032\s])?\s*(?:(\d+(?:\.\d+)?)["\u201d\u2033\s])?\s*([SNEW])?/i
      world.parseLatLon = (latlon) ->
          m = String(latlon).split(latlonrg)
          lat = m && +m[1] + (m[2] || 0) / 60 + (m[3] || 0) / 3600
          lat = -lat if m[4].toUpperCase() == "S"
          lon = m && +m[6] + (m[7] || 0) / 60 + (m[8] || 0) / 3600
          lon = -lon if m[9].toUpperCase() == "W"
          @.getXY(lat, lon)

      # demonstrate the use of parseLatLon for marking a position by geo coords
      dot = r.circle().attr(fill: "r#FE7727:50-#F57124:100", stroke: "#fff", "stroke-width": 2, r: 0)
      attr = world.parseLatLon('33°51′35.9″S, 151°12′40″E') # Sydney
      attr.r = 0
      dot.stop().attr(attr).animate({r: 5}, 1000, "elastic")
