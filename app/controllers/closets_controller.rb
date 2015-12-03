class ClosetsController < ApplicationController

  def new
    @closet = Closet.new
  end

  def show
    @closet = Closet.find(params[:id])
  end

  def create
    @closet = Closet.new(closet_params)
    @closet.save
    redirect_to '/'
  end

  private
  def closet_params
    params.require(:closet).permit(:name, :board_id)
  end


end
