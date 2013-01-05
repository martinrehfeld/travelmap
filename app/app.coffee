class @App
  constructor: ->
    @viewport =
      width:  $(window).width()
      height: $(window).height()

  start: ->
    world = new World 'worldmap', @viewport.width, @viewport.height
    world.draw()

    # zoom out animation
    anim = new ViewBoxAnimation(world.canvas, 1500, x: 0, y: 0, w: 1000, h: 400)
    setTimeout(anim.execute, 0)


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
