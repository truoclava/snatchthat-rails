class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    @item.prices << Price.create(price: params[:item][:price])
    redirect_to new_closet_item_path
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:source_id, :name, :url, :image_url, :source_type)
  end

end
