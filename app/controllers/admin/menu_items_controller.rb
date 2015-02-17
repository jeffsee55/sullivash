class Admin::MenuItemsController < AdminController
  def new
    @menu_item = MenuItem.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @item = MenuItem.create(menu_item_params)
    params[:parent_id] = @item.id
    respond_to do |format|
      format.js {}
    end
  end

  private
    def menu_item_params
      params.require(:menu_item).permit(:name, :parent_id, :menu_id)
    end
end
