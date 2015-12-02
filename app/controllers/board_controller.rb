class BoardController < ApplicationController
  def index
    @closets = Closet.all.find_by(board_id: current_user.id)
  end
end
