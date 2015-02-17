class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :post_categories
  has_many :posts, through: :post_categories

  scope :alphabetical, -> { order("name ASC") }
  scope :regular, -> { where.not(name: "Recent Projects")}

  def nice_name
    name.gsub(/%20/, " ")
  end

  def image
    posts.last.image unless self.posts.empty?
  end
end
