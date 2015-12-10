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

  acts_as_votable

  # it returns hash key => highest_standard_deviation, value = the instance of it
  def get_std_all_items
    analytics_hash = {}
    self.items.each do |item|
      analytics_hash[item.stats.standard_deviation] = item
    end
    analytics_hash
  end

  # it returns hash (only the item that has the highest_standard_deviation)
  # key => highest_standard_deviation, value = the instance of it
  def highest_standard_deviation
    highest_standard_deviation_hash = {}
    analytics_hash = self.get_std_all_items
    highest_standard_deviation = analytics_hash.keys.max
    highest_standard_deviation_instance = analytics_hash[highest_standard_deviation]
    highest_standard_deviation_hash[highest_standard_deviation] = highest_standard_deviation_instance
    highest_standard_deviation_hash
  end

  # it returns hash key => price dif value = the instance of it
  def item_price_change_hash
    new_item_list = {}
    self.items.each do |item|
      new_item_list[item.price_dif] = item
    end
    new_item_list
  end


end
