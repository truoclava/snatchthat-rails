class ItemsController < ApplicationController
  def index
  end

  def new
    @current_user = current_user
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    closet_ids = params[:closet_ids][0]
    closet = Closet.find(closet_ids)
    redirect_to new_closet_item_path(item_id: @item.id, closet_id: closet_ids.first)
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :url)
  end
end
