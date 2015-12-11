class SearchesController < ApplicationController

  def index
    keyword = params[:keyword]
    source_type = params[:item][:source_type]
    if keyword.blank?
      redirect_to new_search_path
    else
      @search = Search.new(keyword, source_type)
      @results = @search.results
    end
  end
end
