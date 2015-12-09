# == Schema Information
#
# Table name: prices
#
#  id         :integer          not null, primary key
#  price      :integer
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Price < ActiveRecord::Base
  belongs_to :item

  def self.price_check
    Item.all.each do |item|
      if item.source_type == "Amazon"
        current_price = item.get_amazon_price
      else
        current_price = item.get_hidefy_price("items/#{item.source_id}")
        price_dif = item.price - current_price
        if price_dif != 0 && current_user.notifications?
          Adapters::TwilioMessageClient.new.send_message(price_dif, item)
        end
      end
      new_price = Price.new(price: current_price)
      item.prices << new_price
    end
    array = []
    Item.last.prices.each do |price|
      array << price.price
    end
    array
  end

end
