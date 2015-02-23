class AddAvailableToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :available, :boolean, default: true
  end
end
