class Admin::CategoriesController < AdminController
  before_filter :set_category, only: [:show, :edit, :update, :destroy]
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "Category was successfully created"
    else
      render :new, notice: "Your category was not created"
    end
  end

  def show
  end

  def update
    @category = Category.friendly.find(params[:id])

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "#{@category.name} was successfully updated"
    else
      redirect_to :back
    end
  end

  def index
    @categories = Category.alphabetical
    @category = Category.new
  end

  def edit
  end

  def destroy
    @category.destroy
    @category.posts.collect do |p|
      p.move_to_uncategorized
    end

    redirect_to admin_categories_path, notice: "#{@category.name} was successfully deleted"
  end

  private

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :tag_color)
  end

end
