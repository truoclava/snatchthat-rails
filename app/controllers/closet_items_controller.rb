class ClosetItemsController < ApplicationController
  def new
    item_id = params[:item_id]
    @item = Item.find(item_id)
  end

  def create
    closet_ids = params[:closet_ids]
    item_id = params[:item_id]
    closet_ids.each do |closet_id|
      @closetitem = ClosetItem.new(closet_id: closet_id, item_id: item_id)
       @item = Item.find(item_id)
      if @closetitem.exists?
        @closetitem.destroy
      else
        @closetitem.save
        track_activity(@item)
      end
    end
    redirect_to '/'
  end

  def destroy
    @closet_item = ClosetItem.find(params[:id])
    @item = Item.find(@closet_item.item_id)
    track_activity(@item)

    @closet_item.destroy

    redirect_to user_closet_path(current_user, @closet_item.closet_id)
  end



end
