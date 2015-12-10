# == Schema Information
#
# Table name: closets
#
#  id         :integer          not null, primary key
#  name       :string
#  board_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Closet < ActiveRecord::Base
  belongs_to :user
  belongs_to :board
  has_many :closet_items
  has_many :items, through: :closet_items

  

end
