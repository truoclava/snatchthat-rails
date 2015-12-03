class ClosetItemsController < ApplicationController
  def create
    binding.pry
    @closet = Closet.find_by
  end
end
