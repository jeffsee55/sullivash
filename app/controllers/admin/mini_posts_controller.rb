class Admin::MiniPostsController < AdminController
  before_action :set_admin_mini_post, only: [:edit, :update, :destroy]

  # GET /admin/mini_posts
  def index
    @home_mini_posts = MiniPost.by_page["Home"]
    @about_mini_posts = MiniPost.by_page["About"]
  end

  # GET /admin/mini_posts/new
  def new
    @mini_post = MiniPost.new
  end

  # GET /admin/mini_posts/1/edit
  def edit
  end

  # POST /admin/mini_posts
  def create
    @mini_post = MiniPost.new(admin_mini_post_params)

    if @mini_post.save
      redirect_to admin_mini_posts_path, notice: 'Mini post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/mini_posts/1
  def update
    if @mini_post.update(admin_mini_post_params)
      redirect_to admin_mini_posts_path, notice: 'Mini post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/mini_posts/1
  def destroy
    @mini_post.destroy
    redirect_to admin_mini_posts_url, notice: 'Mini post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_mini_post
      @mini_post = MiniPost.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_mini_post_params
      params[:mini_post].permit(:title, :body, :page)
    end
end
