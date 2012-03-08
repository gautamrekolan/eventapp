class UsersController < ApplicationController
  
  #puts "requesting show method of usercontroller"
  #helper method authenticate made available from ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  
  respond_to :html, :js
  
  def following
    @title = "following"
    @user = User.find(params[:id])
    @users = @user.following #.paginate(:page => params[:page]) - some shit from Ruby on Rails 3 Tutorial
    render 'show_follow'
  end
  
  def followers
    @title = "followers"
    @user = User.find(params[:id])
    @users = @user.followers #.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def index 
    @users = User.all.limit(100) 
    respond_with @users
  end
  
  def show
    @user = User.find(params[:id])
    # TODO why doesn't this work? Event.find_by_user_id(@user.id) usind where clause as it gives the results i'm looking for
    
    respond_with @user
  end
  
  def new 
    @user = User.new
  end
 
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to events_path, :notice => "user successfully added"
    else 
	    render :new
	  end
  end
  
  def edit 
    # TODO error check if this is the current user every time
    @user = current_user # was: User.find(params[:id]) details in application controller
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
