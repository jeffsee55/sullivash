$ ->
  $('.sidebar .toggle_menu').click ->
    $('.sidebar').toggleClass('show-sidebar', 500, 'swing')
    $(@).toggleClass("spin")
  $(".js-accordion-trigger").bind "click", (e) ->
    $(@).parent().find(".submenu").slideToggle "fast" # apply the toggle to the ul
    e.preventDefault()
  $(window).load ->
    $('.load').fadeOut('slow')
