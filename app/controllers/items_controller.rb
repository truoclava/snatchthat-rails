class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new(item_params)
  end

  def create
    binding.pry

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
    params.require(:item).permit(:source_id, :name, :image_url, :price, :source_type)
  end

end
