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
    price = params[:item][:price]
    price.slice!(0)
    @item.prices << Price.new(price: price)
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

  def prices_over_time
    item = Item.find(params[:id])
    prices_over_time_array = item.prices_over_time
    render :json => {prices_over_time: prices_over_time_array}
  end

  private

  def item_params
    params.require(:item).permit(:source_id, :name, :url, :image_url, :source_type)
  end

end
