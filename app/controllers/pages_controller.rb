class PagesController < ApplicationController
  def home
    @posts = Post.published.first(6)
    @tags = MiniPost.find_by_page("Home")
  end

  def about
    @post = Post.find_by_title("About Me")
  end

  def contact
    @contact = Post.find_by_title("Contact")
  end
end
