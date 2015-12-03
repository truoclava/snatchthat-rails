class BoardsController < ApplicationController
  def index
    @current_user = current_user
    @closets = Closet.where(board_id: @current_user.id)
  end
end
