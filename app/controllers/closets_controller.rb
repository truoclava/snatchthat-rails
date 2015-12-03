class ClosetsController < ApplicationController

  def new
    @current_user = current_user
    @closet = Closet.new
  end

  def show
    @closet = Closet.find(params[:id])
  end

  def create
    @closet = Closet.new(closet_params)
    @closet.save

    # new_closet = Closet.create(name: params[:closet][:name])
    # new_closet.board_id = params[:user_id]
    # new_closet.save
    redirect_to '/'
  end

  private
  def closet_params
    params.require(:closet).permit(:name, :board_id)
  end


end
