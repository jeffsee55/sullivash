class CategoriesController < ApplicationController

  def show
    @q = Post.ransack(params[:q])
    @category = Category.friendly.find(params[:id])
    @posts = @category.posts.published.page params[:page]
  end

  def index
    if params[:parent] == "style"
      @categories = Category.by_style.includes(:posts).alphabetical.reject { |c| c.posts.empty? }
      @title = "By Style"
    elsif  params[:parent] == "subject"
      @title = "By Subject"
      @categories = Category.by_subject.includes(:posts).alphabetical.reject { |c| c.posts.empty? }
    else
      @categories = Category.alphabetical.includes(:posts).reject { |c| c.posts.empty? }
      @title = "All Categories"
    end
  end

end
