class ClosetItemsController < ApplicationController
  def new
  end

  def create
  end

  def destroy
    
    @closet_item = ClosetItem.find(params[:id])
  track_activity(@closet_item)
    @closet_item.destroy
    
    redirect_to user_closet_path(current_user, @closet_item.closet_id)
  end


private
  def closet_item_params
    params.permit(:closet_id, :item_id)
  end
end
