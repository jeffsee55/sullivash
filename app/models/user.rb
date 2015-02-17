class User < ActiveRecord::Base
  include Clearance::User
  has_many :posts
  attachment :image
  
  def name
    "#{first_name} #{last_name}"
  end
end
