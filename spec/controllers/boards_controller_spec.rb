require 'rails_helper'

RSpec.describe BoardsController, type: :controller do

  describe 'basic board function testing' do
    it '#index create a closet' do
      # binding.pry
      @user = User.create!(email:'example@example.com',password:'password',username:'username')
      expect(@user.id).to eq(@user.board.id)
    end
  end

end
