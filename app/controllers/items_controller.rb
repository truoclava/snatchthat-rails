class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    if params[:item] == nil
      @item = Item.new
    else
      @item = Item.new(item_params)
    end
  end

  def create
    if params[:item][:source_type] == "Amazon"
      client = Adapters::AmazonItemClient.new
      item = client.create_from_source_id(params[:item][:source_id])
      item.source_id = "Amazon"
      item.save
    else
      item = Item.new(item_params)
      item.hidefy_create(item.source_id)
      item.save
    end

    closet_ids = params[:closet_ids]
    closet_ids.each do |closet_id|
      ClosetItem.create(closet_id: closet_id, item_id: item.id)
    end

    redirect_to '/'

  end


  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:source_id, :source_type, :price)
  end

end
