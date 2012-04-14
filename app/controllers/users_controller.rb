class UsersController < ApplicationController
  
  #puts "requesting show method of usercontroller"
  #helper method authenticate made available from ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  
  respond_to :html, :js
  
  def checkname
    if User.where('user = ?', params[:user]).count == 0
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 409
    end
    return
  end
  
  def events_gone_to
    @title = "events gone to"
    @user = User.find(params[:id])
    @events = Event.find_all_gone_to_by_user_id(@user.id)
    render 'user_events.js.erb'
  end
  
  def events_created 
    @title = "events gone to"
    @user = User.find(params[:id])
    @events = Event.find_all_by_user_id(@user.id)
    render 'user_events.js.erb'
  end
  
  def following
    @title = "following"
    @user = User.find(params[:id])
    @users = @user.following #.paginate(:page => params[:page]) - some shit from Ruby on Rails 3 Tutorial
    render 'show_follow.js.erb'
  end
  
  def followers
    @title = "followers"
    @user = User.find(params[:id])
    @users = @user.followers #.paginate(:page => params[:page])
    render 'show_follow.js.erb'
  end
  
  def index 
    @users = User.all 
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
      if params[:user][:avatar].blank?
        redirect_to events_path, :notice => "user successfully added"
      else 
        render 'crop'
      end
    else 
	    render :new
	  end
  end
  
  def edit 
    # TODO error check if this is the current user every time
    if current_user == User.find(params[:id])
      @user = current_user # was: User.find(params[:id]) details in application controller
    end
  end
  
  def update
    @user = User.find(params[:id])
	  if @user.update_attributes(params[:user])
	    if params[:user][:avatar].blank?
        redirect_to events_path, :notice => "your account was updated"
      else 
        render 'crop'
      end
  	else 
  	  render :action => 'edit'
  	end
  end

end
