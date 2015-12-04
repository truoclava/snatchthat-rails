class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def should_generate_new_friendly_id?
   new_record? || slug.nil? || slug.blank? # you can add more condition here
  end

  def new
    
  end

  def edit

  end

  def update

  end
end
