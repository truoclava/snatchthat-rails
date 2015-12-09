class ClosetItemsController < ApplicationController
  def new
    @item = Item.last
  end

  def create
    closet_ids = params[:closet_ids]
    if closet_ids == nil
      item = Item.find(params[:item_id])
      item.destroy
    else
      item_id = params[:item_id]
      closet_ids.each do |closet_id|
        @closetitem = ClosetItem.create(closet_id: closet_id, item_id: item_id)
        track_activity(@closetitem)
      end
    end
      # add redirect to closet show page if only added to one closet
    redirect_to '/'
  end

  def destroy
    @closet_item = ClosetItem.find(params[:id])
    track_activity(@closet_item)
    @closet_item.destroy
    redirect_to user_closet_path(current_user, @closet_item.closet_id)
  end


# private
#   def closet_item_params
#     params.permit(:closet_ids, :item_id)
#   end
end
