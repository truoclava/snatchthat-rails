class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:followed_id])
    user = User.find(params[:followed_id])
    track_activity(@user)
    current_user.follow(user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    user = Relationship.find(params[:id]).followed
    track_activity(@user)
    current_user.unfollow(user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end