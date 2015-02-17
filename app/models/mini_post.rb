class MiniPost < ActiveRecord::Base
  scope :by_page, -> { all.group_by(&:page) }
end
