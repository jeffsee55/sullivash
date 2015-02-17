class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  has_many :post_categories
  has_many :categories, through: :post_categories
  attachment :image
  attachment :pinterest_image
  is_impressionable :counter_cache => true

  default_scope -> { order('created_at DESC') }
  scope :site_post, -> { where(site_post: true) }
  scope :regular_post, -> { where(site_post: false) }
  scope :published, -> { where.not(published_at: nil).where(site_post: false).order('published_at DESC') }
  scope :published_non_projects, -> { joins(:categories).where.not("categories.name" => "Recent Projects") }

  accepts_nested_attributes_for :post_categories

  def slug_candidates
    [
      :title,
      [:title, :created_at],
    ]
  end

  def self.check_for_new_posts
    # Check for post published within last 24 hours
    recent_posts = self.where("published_at > '#{30.minutes.ago}'")
    # Send post notification email
    recent_posts.each do |post|
      post.send_email unless post.email_sent?
    end
  end

  def short_title
    title.truncate(100)
  end

  def publish!
    update(published_at: Time.now)
    self.save
  end

  def pinterest_image
  end

  def save_as_draft!
    update(published_at: nil)
  end

  def published?
    published_at != nil
  end

  def move_to_uncategorized
    if self.categories.empty?
      uncategorized = Category.find_by_name("Uncategorized")
      PostCategory.create(post_id: self.id, category_id: uncategorized.id)
    end
  end

  def email_sent?
    email_sent_at != nil
  end

  def body_without_images
    require 'nokogiri'
    doc = Nokogiri::HTML(self.body)
    doc.search("img").remove
    doc.to_html
  end

  def strip_body_tags
    doc = Nokogiri::HTML(self.body)
    body = doc.xpath("//text()").to_s
    return body
  end

  def strip_and_truncate(length)
    doc = Nokogiri::HTML(self.body)
    body = doc.xpath("//text()").to_s
    body[0...length]
  end

  def send_email
    # check again to see if post is still marked published
    if published_at != nil
      recent_projects = Category.find_by_name("Recent Projects")
      unless self.categories.include? recent_projects or self.site_post? or self.email_sent?
        SiteMailer.post_notification(self)
        self.email_sent_at = Time.now
        self.save
      end
    end
  end
end
