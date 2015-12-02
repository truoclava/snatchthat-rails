class Board < ActiveRecord::Base
  belongs_to :user
  has_many :closets
  has_many :closet_items, through: :closets
  has_many :items, through: :closet_items
   validates :user_id, presence: true, uniqueness: true

end
