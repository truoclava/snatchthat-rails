class BoardController < ApplicationController
  def index
    @closets = Closet.where(board_id: 1)
  end
end
