class CreateMiniPosts < ActiveRecord::Migration
  def change
    create_table :mini_posts do |t|
      t.string :title
      t.text :body
      t.string :page

      t.timestamps
    end
  end
end
