# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  source_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ActiveRecord::Base
  has_many :closet_items
  has_many :closets, through: :closet_items

  
  
end
