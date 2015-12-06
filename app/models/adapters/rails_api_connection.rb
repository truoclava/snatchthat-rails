module Adapters
  class RailsApiConnection
    include HTTParty

    attr_reader :connection

    def initialize
       @connection = self.class
    end

    def query
      results = connection.get("http://snatchthat-rails-api.herokuapp.com/api/items")
    end

  end
end
