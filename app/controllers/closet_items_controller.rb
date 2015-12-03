class ClosetItemsController < ApplicationController
  def create
    # binding.pry
    # @closet = Closet.find_by
  end

  def new
    @closet_item = ClosetItem.new(closet_item_params)
    @closet_item.save
    @closet = Closet.find(closet_item_params[:closet_id])

    redirect_to user_closet_path(current_user ,@closet)
  end


private

def closet_item_params
    # binding.pry
    # closet_id = params[:closet_id]
    params.permit(:closet_id, :item_id)
    # params.require(:closet_item).permit(:closet_id, :item_id, controller: :closet_item)
  end
end
