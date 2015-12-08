class SearchesController < ApplicationController

  def index
    keyword = params[:keyword]

    client = Adapters::AmazonSearchClient.new
    results = client.amazon_search(keyword)
    item_asins = []
    results.each do |item|
      item_asins << item["ASIN"]
    end

    @item_asins = item_asins

  end
end
