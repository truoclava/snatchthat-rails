# == Schema Information
#
# Table name: prices
#
#  id         :integer          not null, primary key
#  price      :string
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Price < ActiveRecord::Base
  belongs_to :item

  #need to refactor
  def self.price_check
    Item.all.each do |item|
      if item.source_type == "Amazon"
        current_price = item.get_amazon_price(item.source_id)
        current_price.slice!(0)
        price_dif = item.prices.last.price.to_i - current_price.to_i
        user = item.closets.first.board.user
        if price_dif != 0 && user.notifications?(user.id)
          # uncomment if you need
          # Adapters::TwilioMessageClient.new.send_message(price_dif, item)
        end
      else
        current_price = item.get_hidefy_price("items/#{item.source_id}")
        price_dif = item.prices.last.price.to_i - current_price
        user = item.closets.first.board.user
        if price_dif != 0 && user.notifications?(user.id)
          # Adapters::TwilioMessageClient.new.send_message(price_dif, item)
        end
      end
      new_price = Price.new(price: current_price)
      item.prices << new_price
    end
    "Success"
  end

  #biggest_dropped_item => [40, <item##hduhsoud>]
  def self.get_item_biggest_change
    biggest_change = {}
    Price.all.each do |price|
      item = price.item
      last_price = item.prices[-1]
      second_last_price = item.prices[-2]
      price_change = last_price.price.to_i - second_last_price.price.to_i
      biggest_change[price_change] = price
    end
    biggest_dropped_amount = biggest_change.keys.max
    biggest_dropped_item_instance = biggest_change[biggest_dropped_amount]
    biggest_dropped_item_hash = {biggest_dropped_amount => biggest_dropped_item_instance}
  end


end
