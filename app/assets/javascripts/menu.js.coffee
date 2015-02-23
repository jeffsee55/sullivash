$ ->
  $(".menu").click ->
    $(".full-screen-menu").show()
  $(".exit").click ->
    $(".full-screen-menu").hide()
  more = $(".full-screen-menu .more > a")
  more.click ->
    $(@).siblings("ul").show()
    $(@).hide()
    parentListItem = $(@).parents("li")
    parentListItem.siblings().hide()
    parentListItem.before("<li><a class='back'>MAIN MENU</a></li>")
    $("li .back").click ->
      backListItem = $(@).parents("li")
      otherListItems = $(@).parents("li").siblings("li")
      otherListItems.show()
      otherListItems.find("a").show()
      otherListItems.find("ul").hide()
      backListItem.remove()
