$ ->
  squareBox = (item, divider) ->
    gridWidth = item.width()
    blockMargin = $(".block").css("margin-bottom")
    gridPadding = parseInt(blockMargin, 10)
    gridHeight = (gridWidth / divider) - (gridPadding / 2)
    item.css( "min-height", "#{gridHeight}px" )

  renderGrid = (waypoint) ->
    waypoint.html("<%= j(render partial: 'partials/grid', locals: { home_mini_posts: @home_mini_posts, posts: @posts }) %>")
    console.log "test"
    $(".square").each ->
      squareBox($(@), 1)
      console.log @
    $(".rectangle").each ->
      squareBox($(@), 2)
    $(".grid-items-lines, .project-image").magnificPopup(
      delegate: '.has-image'
      type: "image"
      gallery:
        enabled:true
      image:
        titleSrc: 'title'
    )

  waypoint = new Waypoint(
    element: $('.waypoint').last()
    handler: (direction) ->
      if direction == "down"
        console.log "bottom"
        $(".waypoint a").last().trigger('click')
    offset: "60%"
  )
  renderGrid($(".waypoint").last())
