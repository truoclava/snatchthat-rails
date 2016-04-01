class BoardsController < ApplicationController
  def index
    #@closets = Closet.where(board_id: current_user.id)
    @closets = current_user.closets
  end
end
