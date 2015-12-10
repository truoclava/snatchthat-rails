require 'rails_helper'

RSpec.describe ClosetsController, type: :controller do
  let (:my_closet) do
    Closet.create(
      id: 1,
      name: 'My Test Closet'
    )
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create, {id: my_closet.id}
      expect(response).to have_http_status(:success)
    end
  end

end
