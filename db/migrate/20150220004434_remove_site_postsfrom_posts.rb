class RemoveSitePostsfromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :site_post
  end
end
