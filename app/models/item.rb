# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string
#  url         :string
#  price       :integer
#  source_id   :string
#  source_type :string
#  image_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Item < ActiveRecord::Base
  has_many :closet_items
  has_many :closets, through: :closet_items
  has_many :prices

  def get_hidefy_price(end_path)
    hidefy_item_data = Adapters::HidefyConnection.new.query(end_path)
    current_price = hidefy_item_data["price"]
  end

  def hidefy_create(item_id)
    current_price = get_hidefy_price("items/#{item_id}")
    new_price = Price.new(price: current_price)
    self.prices << new_price
  end


end
