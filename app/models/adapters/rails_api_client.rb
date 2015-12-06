module Adapters
  class RailsApiClient

    def connection
      @connection = Adapters::RailsApiConnection.new
    end

    #gets all item data from rails api. now we have discuss how we should do with these data with search function
    def get_json_data
      json_data = connection.query
    end

  end
end
