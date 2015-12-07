class PriceCheck

  def self.check
    Item.all.each do |item|
      current_price = item.get_current_price
      if current_price != item.price
        price_dif = item.price - current_price

        
        # binding.pry
        # item.update_item
        # if you uncomment the code below, twilio function will work
        # Let's discuss when you see this.
        # Adapters::TwilioMessageClient.new.send_message(price_dif, item)
      else
        # update last check time
      end
    end
  end


end
