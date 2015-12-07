module Adapters
  class TwilioMessageClient

    def connection
      @connection = Adapters::TwilioConnection.new
    end

    def test_message
      old_price = 100
      new_price = 80
      price_dif = old_price - new_price
      item_instance = Item.last
      send_message(price_dif, item_instance)
    end

    def send_message(price_dif, item_instance)
      good_bad_news = comment_creater(price_dif, item_instance)
      #this phone_number is supposed to be item.user.phone_number
      phone_number = '+12016212617'

      message = connection.client.account.messages.create(
        :from => connection.twilio_number,
        :to => phone_number,
        :body => "Hello Hide, your #{item_instance.name}, #{good_bad_news}, link: #{item_instance.url}"
      )
      puts "The notification has been proplery sent to (item.user.name)"
    end

    def comment_creater(price_dif, item_instance)
      if price_dif >= 0
        "Bad news!! the price of #{item_instance.name} has gone up by #{price_dif}. The current price is 80"
      else price_dif <= 0
        "Great news!! the price of #{item_instance.name} has gone down by #{price_dif}. The current price is 100"
      end
    end

  end
end
