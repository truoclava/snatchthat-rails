class TwilioMessage < ActiveRecord::Base

  attr_accessor :client, :twilio_number, :phone_number

    def initialize
      @account_sid = 'ACcfb9256efb61c21830f4ec93497598c7'
      @auth_token = '02e37c6d92cdf53c827b344e535511ad'
      @client = Twilio::REST::Client.new(@account_sid, @auth_token)
      @twilio_number = '+19734197784'
      @phone_number = '+12016212617'
    end

    def send_message
      alert_message = "Yo twilio worked!!"

      message = client.account.messages.create(
        :from => twilio_number,
        :to => phone_number,
        :body => alert_message,
      )
      puts "Success"
    end

end
