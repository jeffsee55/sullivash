class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :post_categories
  has_many :posts, through: :post_categories

  has_many :subcategories, class: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent_category, class: "Category"

  scope :alphabetical, -> { order("name ASC") }
  scope :by_style, -> { where(parent: "style") }
  scope :by_subject, -> { where(parent: "subject") }

  def nice_name
    name.gsub(/%20/, " ")
  end

  def image
    posts.last.image unless self.posts.empty?
  end

  def random_post
    count = posts.count
    self.posts[rand(0..(count - 1))]
  end

  def cleanup_posts
   self.posts.collect do |p|
    p.move_to_uncategorized
   end
  end

end
