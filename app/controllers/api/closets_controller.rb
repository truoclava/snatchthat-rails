class Api::ClosetsController < ApplicationController
  def index
    @closets = Closet.all
    render json: @closets
  end
end
