class PostsController < ApplicationController
  before_filter :verify_and_set_post, only: :show

  def show
    @prev = Post.prev_post(@post)
    @next = Post.next_post(@post)

    impressionist(@post)
    @post.impressionist_count(filter: :session_hash)
  end

  def index
    if params[:posts]
      posts = params[:posts]
      @posts = posts.published.page params[:page]
    elsif params[:year]
      year = params[:year]
      year = year.to_date
      @year = year.year
      @posts = Post.published.where(published_at: year.beginning_of_year..year.end_of_year).page params[:page]
    else
      @posts = Post.published
      @posts_years = @posts.group_by { |p| p.published_at.beginning_of_year }
    end
  end

  def search
    if params[:q]
      @posts = @q.result(distinct: true)
    else
      @posts = Post.first(3)
    end
  end

  private

  def verify_and_set_post
    @post = Post.friendly.find(params[:id])
    unless @post.published?
      redirect_to root_path, notice: "Sorry, this post is not public"
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :image)
  end

end
