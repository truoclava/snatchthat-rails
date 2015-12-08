class SearchesController < ApplicationController

  def index
    keyword = params[:keyword]
    source_type = params["source_type"]

    client = Adapters::AmazonSearchClient.new
    results = client.amazon_search(keyword)
    item_asins = []
    results.each do |item|
      item_asins << item["ASIN"]
    end

    @item_asins = item_asins

  end

  def hidefy
    @data_hash = Adapters::HidefyConnection.new.query("items")["items"]
    render partial: 'hidefy'
  end

end
