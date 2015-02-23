class AddStyleToCategoriesRemoveParent < ActiveRecord::Migration
  def change
    add_column :categories, :style, :string
    remove_column :categories, :parent_id
  end
end
