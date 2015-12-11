class Api::ItemsController < ApplicationController
  def index
    @items = Item.all
    render json: @items
  end
end
