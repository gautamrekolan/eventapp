class SessionsController < ApplicationController
  
  def create 
    if user = User.authenticate(params[:email], params[:password])
	  session[:user_id] = user.id
	  redirect_to root_path, :notice => "login successful"
	  else 
	    flash.now[:alert] = "invalid login / password combination " + params[:password]
	    render :action => "new"
	  end
  end
    
  def destroy 
    reset_session
	  redirect_to root_path, :notice => "you successfully logged out"
  end
  
end
