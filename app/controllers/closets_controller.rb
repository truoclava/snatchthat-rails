class ClosetsController < ApplicationController

  def index
    @closets = Closet.all
  end

  def new
    @closet = Closet.new
  end

  def show
    @closet = Closet.find(params[:id])
  end

  def create
    @closet = Closet.new(closet_params)
    @closet.save
    track_activity(@closet)
    redirect_to '/'
  end

  def destroy
    @closet = Closet.find(params[:id])
    @closet.destroy
    track_activity(@closet)
    redirect_to '/'
  end

  private
  def closet_params
    params.require(:closet).permit(:name, :board_id, :user_id)
  end


end
