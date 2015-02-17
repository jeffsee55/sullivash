class Admin::MenusController < AdminController

  def new
    @menu = Menu.create
    redirect_to admin_menu_path(@menu)
  end

  def create
    @menu = Menu.create
  end

  def edit
  end

  def index
  end

  def update
  end

  def destroy
  end

  def show
    @menu_item = MenuItem.new
  end

  private

    def menu_params
    end

end
