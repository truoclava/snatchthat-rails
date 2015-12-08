module Adapters
  class AmazonConnection
    include HTTParty

    attr_reader :connection

    def initialize
      @connection = Vacuum.new('US').configure(
        aws_access_key_id: ENV['aws_access_key_id'],
        aws_secret_access_key: ENV['aws_secret_access_key'],
        associate_tag: 'tag'
      )
    end


  end
end
