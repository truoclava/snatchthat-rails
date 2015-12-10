module Adapters
  class AmazonPriceClient

    def connection
      (Adapters::AmazonConnection.new).connection
    end

    def get_amazon_price(source_id)
      # can specify operation in params 'Operation' => 'ItemLookup',
      # results = connection.get(query: params).to_h
      params = {
        'ItemId' => source_id,
        'ResponseGroup'=> 'ItemAttributes, Images, Offers, Variations'}

      results = connection.item_lookup(query: params).to_h

      info = results['ItemLookupResponse']['Items']['Item']

      price = info['OfferSummary']['LowestNewPrice']['FormattedPrice']
    end

  end
end
