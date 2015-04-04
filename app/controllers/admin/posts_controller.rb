class Admin::PostsController < AdminController
  layout 'post', only: [:new, :edit]
  before_action :set_post, only: [:edit, :update, :show, :destroy, :set_featured]

  def new
    @post = Post.new
    @categories = Category.all
  end

  def set_featured
    if @post.set_featured(@featured_post)
      redirect_to :back, notice: "#{@post.title} is now the featured post."
    else
      redirect_to :back, alert: "#{@post.title} cannot be set as featured, is it published?"
    end
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      if publishing?
        published_at = DateTime.new(post_params["published_at(1i)"].to_i, post_params["published_at(2i)"].to_i, post_params["published_at(3i)"].to_i, post_params["published_at(4i)"].to_i, post_params["published_at(5i)"].to_i)
        @post.publish!(published_at)
      else
        @post.save_as_draft!
      end
      if params[:category_ids]
        params[:category_ids].each do |category_id|
          PostCategory.create(
            post_id: @post.id,
            category_id: category_id
          )
        end
      end
      redirect_to admin_post_path(@post), notice: "#{@post.title} was susccessfully created"
    end
  end

  def show
  end

  def index
    if params[:posts]
      @posts = params[:posts]
    else
      @posts = Post.all.page params[:page]
    end
  end

  def search
    if params[:q]
      @posts = @q.result(distinct: true)
    else
      @posts = Post.first(3)
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    @post.update(post_params)
    if @post.save
      if publishing?
        published_at = DateTime.new(post_params["published_at(1i)"].to_i, post_params["published_at(2i)"].to_i, post_params["published_at(3i)"].to_i, post_params["published_at(4i)"].to_i, post_params["published_at(5i)"].to_i)
        @post.publish!(published_at)
      else
        @post.save_as_draft!
      end
      if params[:category_ids]
        PostCategory.where(post_id: @post.id).delete_all
        params[:category_ids].map do |category_id|
          PostCategory.create(
            post_id: @post.id,
            category_id: category_id
          )
        end
      end
      redirect_to admin_post_path(@post), notice: "#{@post.title} was susccessfully updated"
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to admin_posts_path, alert: "#{@post.title} was successfully deleted" }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end


  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :image, :details, "published_at(1i)", "published_at(2i)", "published_at(3i)", "published_at(4i)", "published_at(5i)", :remove_image, :available, post_categories_attributes: [:post_id])
  end

  def publishing?
    params["commit"] == "Publish"
  end

  def drafting?
    params["commit"] == "Save as Draft"
  end

end
