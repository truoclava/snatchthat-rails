class ClosetItemsController < ApplicationController
  def create
    binding.pry
    @closet = Closet.find_by
  end

  def new
    binding.pry
  end

end
