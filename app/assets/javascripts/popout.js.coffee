$ ->
  $('.plus').click ->
    console.log 'click'
    $(@).parent('li').children('.popout').slideToggle(800, 'easeOutBounce')
    $(@).toggleClass('rotate')
