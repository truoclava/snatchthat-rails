module Adapters
  class AmazonSearchClient

    def connection
      (Adapters::AmazonConnection.new).connection
    end

    def amazon_search(keyword)
      hashed_results = connection.item_search(query: params(keyword)).to_h
    end

    def params(keyword)
      {
        'Availability' => 'Available',
        'Keywords' => keyword,
        'SearchIndex' => 'Fashion',
        'ResponseGroup' => 'ItemAttributes, Offers, Images, Variations'}.to_h
    end
  end
end
