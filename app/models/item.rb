# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  price      :integer
#  source_id  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ActiveRecord::Base
  has_many :closet_items
  has_many :closets, through: :closet_items
  has_many :prices
end
