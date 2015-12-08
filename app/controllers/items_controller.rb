class ItemsController < ApplicationController
  def index
  end

  def new
    if params[:item] == nil
      @item = Item.new
    else
      @item = Item.new(item_params)
    end
  end

  def create
    @item = Item.new(item_params)
    @item.amazon_info
    @item.save
    track_activity(@item)
    client = Adapters::AmazonItemClient.new
    @item = client.create_from_source_id(item_params[:source_id])

    closet_ids = params[:closet_ids][0]
    closet = Closet.find(closet_ids)
    redirect_to new_closet_item_path(item_id: @item.id, closet_id: closet_ids.first)
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:source_id)
  end
end
