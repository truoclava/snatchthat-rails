require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let (:my_item) do
    Item.create(
      id: 1,
      name: 'Blah Test'
    )
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "can create a new item" do
      get :new
      expect(assigns(:item)).to be_a_new(Item)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_item.id}
      expect(response).to have_http_status(:success)
    end
  end

end
