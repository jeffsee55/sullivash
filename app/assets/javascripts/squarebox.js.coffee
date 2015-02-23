$ ->
  squareBox = (item, divider) ->
    gridWidth = item.width()
    blockMargin = $(".block").css("margin-bottom")
    gridPadding = parseInt(blockMargin, 10)
    gridHeight = (gridWidth / divider) - (gridPadding / 2)
    item.css( "min-height", "#{gridHeight}px" )

  $(".square").each ->
    squareBox($(@), 1)
  $(".rectangle").each ->
    squareBox($(@), 2)

  $(window).resize ->
    $(".square").each ->
      squareBox($(@), 1)
    $(".rectangle").each ->
      squareBox($(@), 2)


  # $(".fit-text").fitText()
