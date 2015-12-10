# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Board < ActiveRecord::Base
  belongs_to :user
  has_many :closets
  has_many :closet_items, through: :closets
  has_many :items, through: :closet_items
  validates :user_id, presence: true, uniqueness: true












end
