# == Schema Information
#
# Table name: closet_items
#
#  id         :integer          not null, primary key
#  closet_id  :integer
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ClosetItem < ActiveRecord::Base
  belongs_to :closet
  belongs_to :item
  

end
