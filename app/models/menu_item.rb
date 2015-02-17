class MenuItem < ActiveRecord::Base
  belongs_to :menu
  belongs_to :parent_cateogory, class_name: "MenuItem"
  has_many :sub_items, class_name: "MenuItem", foreign_key: "parent_id", dependent: :destroy

  def find_link
    
  end
end
