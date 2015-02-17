$ ->
  $("#category_tag_color,
      #theme_header_bg,
      #theme_footer_bg,
      #theme_button_bg,
      #theme_primary_gradient,
      #theme_secondary_gradient,
      #theme_icon_color").colpick(
    layout: "hex"
    submit: 0
    onChange: (hsb, hex, rgb, el, bySetColor) ->
      console.log(el.id)
      if el.id == "theme_icon_color"
        $(el).parents(".card").find(".item").css("color", "##{hex}")
      else if el.id == "theme_primary_gradient"
        other_gradient = $("#theme_secondary_gradient").val()
        console.log other_gradient
        $(el).parents(".card").find(".item").css("background", "linear-gradient(##{hex}, #{other_gradient}").css("opacity", "0.5")
      else if el.id == "theme_secondary_gradient"
        other_gradient = $("#theme_primary_gradient").val()
        console.log other_gradient
        $(el).parents(".card").find(".item").css("background", "linear-gradient(#{other_gradient}, ##{hex}").css("opacity", "0.5")
      else
        $(el).parents(".card").find(".item").css("background-color", "##{hex}")
      $(el).val "##{hex}" unless bySetColor
      return
  ).keyup ->
    $(this).colpickSetColor @value
    color = $(@).val()
    unless color.slice(0,1) == "#"
      $(@).val("##{color}")
    return
