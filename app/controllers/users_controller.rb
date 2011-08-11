class UsersController < ApplicationController
  
  #helper method authenticate made available from ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  
  def new 
    @user = User.new
  end
 
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to events_path, :notice => "user successfully added"
    else 
	  render :action => 'new'
	end
  end
  
  def edit 
    @user = current_user # was: User.find(params[:id])
  end
  
  def update
    @user = current_user # was: User.find(params[:id])
	if @user.update_attributes(params[:user])
	  redirect_to events_path, :notic => "user updated successfully"
	else 
	  render :action => 'edit'
	end
  end


end
