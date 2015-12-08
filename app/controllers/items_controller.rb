class ItemsController < ApplicationController
  def index
  end

  def new
    binding.pry
    if params[:item] == nil
      @item = Item.new
    else
      @item = Item.new(item_params)
    end
  end

  def create
    binding.pry
    if params[:item][:source_type] == "Amazon"
      item = Item.new(item_params)
      item.amazon_info
      item.save
    else
      item = Item.new(item_params)
      item.hidefy_create(item.source_id)
      item.save
    end
    closet_ids = params[:closet_ids][0]
    closet = Closet.find(closet_ids)
    redirect_to new_closet_item_path(item_id: item.id, closet_id: closet_ids.first)
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:source_id, :source_type, :price)
  end
end
