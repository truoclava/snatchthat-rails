class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    client = Adapters::AmazonItemClient.new
    @item = client.create_from_source_id(item_params[:source_id])

    closet_ids = params[:closet_ids]
    closet_ids.each do |closet_id|
      ClosetItem.create(closet_id: closet_id, item_id: @item.id)
    end

    redirect_to '/'

    # closet_ids = params[:closet_ids]
    # closet_ids.each do |closet_id|
    #   ClosetItem.create(closet_id: closet_id, item_id: @item.id)
    # end

  end

  def show
    @item = Item.find(params[:id])
  end

  # def destroy
  #   @item = Item.find(params[:id])
  #   @item.destroy
  #   redirect_to '/'
  # end


  private

    def item_params
      params.require(:item).permit(:source_id)
    end
end
