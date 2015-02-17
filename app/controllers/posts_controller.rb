class PostsController < ApplicationController
  before_filter :verify_and_set_post, only: :show

  def show
    impressionist(@post)
    @post.impressionist_count(filter: :session_hash)
  end

  def index
    if params[:posts]
      posts = params[:posts]
      recent_posts_category = Category.find_by_name("Recent Projects")
      @posts = posts.published.page params[:page]
    else
      @posts = Post.published.page params[:page]
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
      redirect_to root_path, notice: "This post is not available"
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :image)
  end

end
