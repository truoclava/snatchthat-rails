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
      if @closetitem.exists?
        @closetitem.destroy
      else
        @closetitem.save
        track_activity(@closetitem)
      end
      
    end
    redirect_to '/'
  end

  def destroy
    @closet_item = ClosetItem.find(params[:id])
    track_activity(@closet_item)
    @closet_item.destroy
    
    redirect_to user_closet_path(current_user, @closet_item.closet_id)
  end



end
