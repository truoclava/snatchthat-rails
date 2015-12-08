class UsersController < ApplicationController

  def show
   @user = User.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @user }
   end
  end

  def should_generate_new_friendly_id?
   new_record? || slug.nil? || slug.blank? # you can add more condition here
  end

  def new

  end



  def following
    @user = User.friendly.find(params[:id])
    @following = @user.following
  end

  def followers
    @user = User.friendly.find(params[:id])
    @followers = @user.followers
  end

  def edit

  end

  def update

  end
end
