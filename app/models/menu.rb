class Menu < ActiveRecord::Base
  has_many :menu_items, foreign_key: :menu_id
  accepts_nested_attributes_for :menu_items
end
