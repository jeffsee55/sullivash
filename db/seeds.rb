# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'
require 'nokogiri'
#
# cat = Nokogiri::XML(open("https://therealisticorganizer.blogspot.com/feeds/posts/default/-/wrongterm"))
# cat.root.css('category').each do |c|
#   category = c.attribute('term').to_s.strip.gsub(' ', '%20')
#   doc = Nokogiri::XML(open("http://therealisticorganizer.blogspot.com/feeds/posts/default/-/#{category}"))
#   doc.root.css('entry').each do |post|
#     id = post.css('id').to_s
#     post_id = id.split('post-')[1].split("<")[0]
#     title = post.css('title')
#     published = post.css('published')
#     updated = post.css('updated')
#     body = post.css('content')
#     user = post.css('user')
#     doc = Nokogiri::HTML(body.text)
#     second_image = doc.xpath("//img")[0]['src'].split(" ")[0]
#     post = Post.find_or_create_by(unique_number: post_id) do |p|
#       p.title = title.text
#       p.body = body.text
#       p.created_at = published.text
#       p.updated_at = updated.text
#       p.unique_number = post_id
#       backend = Refile.backends["store"]
#       file = backend.upload(open(second_image))
#       p.image = file
#     end
#     category_record = Category.find_or_create_by(name: category.gsub("%20", " "))
#     PostCategory.create(
#       post_id: post.id,
#       category_id: category_record.id
#     )
#   end
# end


doc = Nokogiri::XML(open("/Users/jeffsee55/Downloads/ashleysullivan.wordpress.2015-02-16.xml"))
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
      img_details = img_string.split("/>")[-1].gsub(/ *\n+/, "").gsub(/"/, " ")
    end
    categories = []
    i.css("category").children.each do |category|
      categories << category.text
    end
    p = Post.create(
      title: title,
      published_at: published,
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
