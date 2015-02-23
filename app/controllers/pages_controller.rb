class PagesController < ApplicationController
  def home
    @posts = Post.published.first(6)
    @home_mini_posts = MiniPost.by_page["Home"]
  end

  def about
  end

  def contact
    @mini_post = MiniPost.find_by_page("Contact")
    @message = Message.new
  end
end
