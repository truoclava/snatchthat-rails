class SearchesController < ApplicationController

  def index
    keyword = params[:keyword]
    source_type = params[:item][:source_type]


    @results = Search.create_results_hash(keyword, source_type)
    @keyword = keyword
    @source_type = source_type

  end

end
