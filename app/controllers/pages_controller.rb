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

  def grid
    index = params[:index].to_i
    range = (6*index)..(6*index + 5)
    @posts = Post.published[range]
    @home_mini_posts = MiniPost.by_page["Home"]
    @index = index + 1
    respond_to do |format|
        format.js
    end
  end
end
