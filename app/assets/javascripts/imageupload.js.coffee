$ ->
  source = ""
  image_placeholder = ""
  image_type = ""
  image_id = ""
  $(".image_upload").click ->
    image_type =  $(@).attr('id')
    source = $(@).siblings("input[type='hidden']")
    image_placeholder = $(@).siblings("#image")
  $(document).on "upload:start", "form", (e) ->
    $(this).find("input[type=submit]").attr "disabled", true
    image_placeholder.html $("<div class='image-loading'><i class='fa fa-circle-o-notch fa-spin fa-3x'></i></div>")
  $(document).on "upload:progress", "form", (e) ->
  $(document).on "upload:success", "form", (e) ->
    $(@).find("input[type=submit]").removeAttr "disabled" unless $(@).find("input.uploading").length
    image_id = JSON.parse(source.val()).id
    $("i.fa.fa-circle-o-notch, .image-loading").remove()
    image_placeholder.css("background" :  "url('/attachments/cache/#{image_id}/image') no-repeat center", "background-size" : "cover")
    if image_type == "post_image"
      console.log "Image id: #{image_id}"
      $("#image.post_image").css("background" :  "url('/attachments/cache/#{image_id}/image') no-repeat center", "background-size" : "cover")

