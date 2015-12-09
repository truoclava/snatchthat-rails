module Adapters
  class AmazonSearchClient

    def connection
      (Adapters::AmazonConnection.new).connection
    end

    def amazon_search(keyword)
      hashed_results = results(keyword)
      hashed_results["ItemSearchResponse"]["Items"]["Item"]
    end

    def results(keyword)
      params = {
        'Availability' => 'Available',
        'Keywords' => keyword,
        'SearchIndex' => 'Fashion',
        'ResponseGroup' => 'ItemAttributes, Offers, Images, Variations'}.to_h
      connection.item_search(query: params).to_h
    end




  end
end
