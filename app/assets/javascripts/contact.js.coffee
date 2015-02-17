$ ->
  setBoxHeight = ->
      a = $("#recent-projects")
      b = $("#about-me")
      c = $("#work-with-me")
      tallestBox = Math.max.apply(Math, [a.height(), b.height(), c.height()])
      a.find(".body").css("min-height", "#{tallestBox}px")
      b.find(".body").css("min-height", "#{tallestBox}px")
      c.find(".body").css("min-height", "#{tallestBox}px")

  setBoxHeight.call()
