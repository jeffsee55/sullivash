class PostsController < ApplicationController
  before_filter :verify_and_set_post, only: :show

  def show
    @categories = Category.regular
    @subscriber = Subscriber.new
    @posts = Post.published.group_by { |post| post.published_at.beginning_of_month }

    impressionist(@post)
    @post.impressionist_count(filter: :session_hash)
  end

  def new
    @post = Post.new
  end

  def create
    @post.new(post_params)
    if @post.save
      redirect_to @post, notice: "Your post was successfully created"
    else
      redirect_to :new, notice: "There was a problem creating your post"
    end
  end

  def index
    if params[:posts]
      posts = params[:posts]
      recent_posts_category = Category.find_by_name("Recent Projects")
      @posts = posts.published_non_projects.page params[:page]
    else
      @posts = Post.published_non_projects.page params[:page]
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
