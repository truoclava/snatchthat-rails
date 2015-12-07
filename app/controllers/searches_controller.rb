class SearchesController < ApplicationController

  def index
    @item_array = []
    @array = Search.amazon_data.to_h['ItemSearchResponse']['Items']['Item']
    @array.each do |item|
      @item_array << item["DetailPageURL"]
    end
    @item_array
  end


end
