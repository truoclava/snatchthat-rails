# == Schema Information
#
# Table name: twilio_messages
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TwilioMessage < ActiveRecord::Base

  attr_accessor :client, :twilio_number, :phone_number

    def initialize
      @account_sid = ENV["twilio_sid"]
      @auth_token = ENV["twilio_auth_token"]
      @client = Twilio::REST::Client.new(@account_sid, @auth_token)
      @twilio_number = ENV["twilio_our_num"]
    end


    def send_message
      message_body = "Do you see this message???? Twilio testing worked!! tada~~~! "

      phone_number = '+12016212617'
      message = client.account.messages.create(
        :from => twilio_number,
        :to => phone_number,
        :body => message_body,
      )
      puts "Success"
    end

end
