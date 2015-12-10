module Adapters
  class TwilioMessageClient

    def connection
      @connection = Adapters::TwilioConnection.new
    end

    def send_message(price_dif, item_instance)
      good_bad_news = comment_creater(price_dif, item_instance)
      phone_number = "+#{item_instance.closets.first.board.user.phone_number}".to_i

      message = connection.client.account.messages.create(
        :from => connection.twilio_number,
        :to => phone_number,
        :body => "Hello Hide, your #{item_instance.name}, #{good_bad_news}, link: #{item_instance.url}"
      )
      return "The notification has been properly sent to (item.user.name)"
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
