class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.exists?
      @item = Item.find_by(source_id: @item.source_id)
    end
    @item.prices << Price.new(price: params[:item][:price])
    @item.save
    redirect_to new_closet_item_path(:item_id => @item)
  end

  def show
    @item = Item.find(params[:id])
  end

  def upvote
    @item = Item.find(params[:id])
    @item.upvote_by current_user
    redirect_to :back
  end

  private

  def item_params
    params.require(:item).permit(:source_id, :name, :url, :image_url, :source_type)
  end

end
