class RelationshipsController < ApplicationController

  def create
     @user = User.find(params[:followed_id])
     # binding.pry
    user = User.find(params[:followed_id])
    
    current_user.follow(user)
    track_activity(user)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
     @user = Relationship.find(params[:id]).followed

    user = Relationship.find(params[:id]).followed
    
    current_user.unfollow(user)
    track_activity(user)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end