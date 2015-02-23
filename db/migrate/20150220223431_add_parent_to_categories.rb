class AddParentToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :parent, :string
    remove_column :categories, :style
  end
end
