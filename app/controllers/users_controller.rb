class UsersController < ApplicationController
  
  #puts "requesting show method of usercontroller"
  #helper method authenticate made available from ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  
  def index 
    @user = current_user
    respond_to do |format|
      format.html
      format.xml { render :xml => @user}
    end
  end
  
  def show
    
    @user = current_user
    
    # TODO need to check if it's the current user or if it's another user
    # if it's not the current user obviously they need to see a restricted version of another person's profile
    
    # TODO why doesn't this work? Event.find_by_user_id(@user.id) usind where clause as it gives the results i'm looking for
    
    @requested_user = User.find(params[:id])
    
    # this will give you either the current logged in user's events or the somebody else's profile
    @userevents = user_events(@requested_user)
    
    # puts "USER askjdf" + params[:id].to_s
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
    
  end
  
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
