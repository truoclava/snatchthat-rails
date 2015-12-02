require 'spec_helper'

RSpec.describe User, type: :model do 

  describe "#user" do 
    
    let (:user){FactoryGirl.create(:user)}
    context 'when there is no email' do 
      it 'is invalid if there is no email' do 
        user.email = nil
        expect(user).to_not be_valid
      end
    end
    # binding.pry
  end
end
