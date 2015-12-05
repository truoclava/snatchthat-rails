class PriceCheck

  def self.check
    Item.all.each do |item|
      current_price = item.get_current_price
      if current_price != item.price
        # binding.pry
        # item.update_item
        # notifyuser Adapters::TwilioMessageClient.new.send_message(price_change)
      else
        # update last check time
      end
    end
  end


end
