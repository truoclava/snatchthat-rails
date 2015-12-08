class Price < ActiveRecord::Base
  belongs_to :item

  # def self.check
  #   Item.all.each do |item|
  #
  #     current_price = item.get_current_price
  #     new_price = Price.new(price: current_price)
  #     item.prices << new_price
  #
  #     if current_price != item.price
  #       price_dif = item.price - current_price
  #       Adapters::TwilioMessageClient.new.send_message(price_dif, item)
  #     end
  #       # item.update_item
  #   end
  # end
  #
  def self.test_check
    Item.all.each do |item|
      if item.source_type == "Amazon"
        current_price = item.get_amazon_price
      else
        current_price = item.get_hidefy_price("items/#{item.source_id}")
        price_dif = item.price - current_price
        if current_user.notifications == true
          Adapters::TwilioMessageClient.new.send_message(price_dif, item)
        end
      end
      new_price = Price.new(price: current_price)
      item.prices << new_price
  end

end
