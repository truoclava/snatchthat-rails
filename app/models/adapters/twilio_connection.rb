module Adapters
  class TwilioConnection
    include HTTParty

    attr_reader :client, :twilio_number

    def initialize
      @client = Twilio::REST::Client.new(ENV["twilio_sid"], ENV["twilio_auth_token"])
      @twilio_number = ENV["twilio_our_num"]
    end

  end
end
