class SearchesController < ApplicationController

  def index
    keyword = params[:keyword]

    rename = Adapters::AmazonConnection.new
    client = rename.connection

    results = client.item_search(
    query: {
      'Keywords' => keyword,
      'SearchIndex' => 'Apparel',
      'ResponseGroup' => 'Variations'
    }).to_h

    items = results['ItemSearchResponse']['Items']['Item']
    item_asins = []
    items.each do |item|
      item_asins << item['ASIN']
    end
    @item_asins = item_asins

  end
end