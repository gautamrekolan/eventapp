class RelationshipsController < ApplicationController
  # TODO a similar implemntation to what we have here should be used in going to's
  before_filter :authenticate

  respond_to :html, :js
  
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_with @user
  end

  def destroy 
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end
end
