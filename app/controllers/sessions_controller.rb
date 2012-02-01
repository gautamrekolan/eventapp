class SessionsController < ApplicationController
  
  def create 
    if user = User.authenticate(params[:email], params[:password])
	    session[:user_id] = user.id
	    user.last_login = Time.now
	    user.save
	    redirect_to root_path, :notice => "login successful"
	  else 
	    flash.now[:alert] = "invalid login / password combination " # don't show pass + params[:password]
	    #render :action => "new"
	    redirect_to login_path, :notice => "wrong user pass"
	  end
  end
    
  def destroy 
    reset_session
	  redirect_to root_path, :notice => "you successfully logged out"
  end
  
end
