class Closet < ActiveRecord::Base
  belongs_to :board
  has_many :closet_items
  has_many :items, through: :closet_items
  
end
