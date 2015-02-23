class Admin::PostsController < AdminController
  layout 'post', only: [:new, :edit]
  before_action :set_post, only: [:edit, :update, :show, :destroy, :set_featured]

  def new
    @post = Post.new
    @categories = Category.all
  end

  def set_featured
    if @post.set_featured
      redirect_to :back, notice: "#{@post.title} is now the featured post."
    else
      redirect_to :back, notice: "#{@post.title} cannot be set as featured, is it published?"
    end
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      @post.publish! if publishing?
      @post.save_as_draft! if drafting?
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
      @posts = Post.page params[:page]
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
      @post.publish! if publishing?
      @post.save_as_draft! if drafting?
      if params[:category_ids]
        params[:category_ids].each do |category_id|
        PostCategory.where(post_id: @post.id).delete_all
        PostCategory.create(
          post_id: @post.id,
          category_id: category_id
          )
        end
      end
      redirect_to admin_post_path(@post), alert: "#{@post.title} was susccessfully updated"
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to admin_posts_path, notice: "#{@post.title} was successfully deleted" }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end


  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :image, :remove_image, :available, post_categories_attributes: [:post_id])
  end

  def publishing?
    params["commit"] == "Publish"
  end

  def drafting?
    params["commit"] == "Save as Draft"
  end

end
