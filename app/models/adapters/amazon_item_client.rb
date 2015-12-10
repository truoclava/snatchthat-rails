module Adapters
  class AmazonItemClient

    def connection
      (Adapters::AmazonConnection.new).connection
    end

    def create_from_source_id(source_id)
      # can specify operation in params 'Operation' => 'ItemLookup',
      # results = connection.get(query: params).to_h
      params = {
        'ItemId' => source_id,
        'ResponseGroup'=> 'ItemAttributes, Images, Offers, Variations'}

      results = connection.item_lookup(query: params).to_h

      info = results['ItemLookupResponse']['Items']['Item']

      name = info['ItemAttributes']['Title']
      url = info['DetailPageURL']
      image_url = info['MediumImage']['URL']
      price = info['OfferSummary']['LowestNewPrice']['FormattedPrice']

      Item.create(name: name, url: url, price: price, source_id: source_id, image_url: image_url)
    end

  end
end
