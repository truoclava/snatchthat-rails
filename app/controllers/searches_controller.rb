class SearchesController < ApplicationController

  def index
    keyword = params[:keyword]
    source_type = params["source_type"]

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

  def hidefy
    @data_hash = Adapters::HidefyConnection.new.query("items")["items"]
    render partial: 'hidefy'
  end

end
