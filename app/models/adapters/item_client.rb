module Adapters
  class ItemClient
    def connection
      @connection = Adapters::AmazonConnection.new
    end

    def create_by_source_id(source_id)

    end

    # def find_by_name(name)
    #   results = connection.query(q: name, type: 'artist')
    #   artists = results.artists.items
    #   artist_objects = artists.map do |artist_struct|
    #     # Artist.find_or_initialize_by(name: )
    #     Artist.new(name: artist_struct.name, spotify_id: artist_struct.id)
    #   end
    # end


  end
end
