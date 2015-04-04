class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :post_categories
  has_many :posts, through: :post_categories

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
    post = self.posts[rand(0..(count - 1))]
    if post.image_id.nil?
      return Post.where.not(image_id: nil).first
    else
      return post
    end
  end

  def cleanup_posts
   self.posts.collect do |p|
    p.move_to_uncategorized
   end
  end

end
