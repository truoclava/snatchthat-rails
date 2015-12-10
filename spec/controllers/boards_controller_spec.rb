require 'rails_helper'

RSpec.describe BoardsController, type: :controller do

  describe 'basic board function testing' do
    it 'can instantiate a board' do
      # binding.pry
      @user = User.create!(email:'example@example.com', password:'password', username:'username', phone_number: '5124592222')
      expect(@user.id).to eq(@user.board.id)
    end
  end

end
