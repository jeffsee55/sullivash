require 'open-uri'
require 'nokogiri'

doc = Nokogiri::XML(open("sullivash_wordpress.xml"))
items = doc.css("rss").css("channel").css("item")
items.each do |i|
  if i.xpath("wp:post_type").text == "post"
    title = i.css("title").text
    published = i.css("pubDate").text
    img_string = i.at_xpath("content:encoded").children[0].text
    img_http = img_string[/img.*?src="(.*?)"/i,1]
    unless  img_http.blank?
      # Make it an https request
      img_https = img_http.gsub("http:", "https:")
      # strip out line breaks and quotes from details
      img_details = img_string.split("/>")[-1].gsub(/ *\n+/, ",").gsub(/"/, ",").gsub("[/caption]", "").split(",").map { |d| d.upcase }.join("\n")
    end
    categories = []
    i.css("category").children.each do |category|
      categories << category.text
    end
    p = Post.create(
      title: title,
      published_at: published,
      created_at: published,
      details: img_details,
      body: title
    )
    backend = Refile.backends["store"]
    file = backend.upload(open(img_https)) if img_https
    p.image = file if file
    p.save
    new_cats = []
    categories.each do |category|
      new_cats << Category.find_or_create_by(name: category)
    end
    new_cats.each do |category|
      PostCategory.create(
        post_id: p.id,
        category_id: category.id
      )
    end
  end
end
