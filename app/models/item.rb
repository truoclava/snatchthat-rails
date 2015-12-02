class Item < ActiveRecord::Base
  has_many :closet_items
  has_many :closets, through: :closet_items
end
