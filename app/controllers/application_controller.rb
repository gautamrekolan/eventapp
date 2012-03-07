class ApplicationController < ActionController::Base

  #before_filter :authenticate, :except => [:index, :show, :login]
  
  protect_from_forgery
  
  puts "ACTION NAME " + controller_name
  
  #returns the currently logged in user or nil if there isn't one
  protected
	def current_user
	  return unless session[:user_id]
	  @current_user ||= User.find_by_id(session[:user_id])
	end
	#make current method available in other templates as a helper
	helper_method :current_user
  
  protected
  def current_user?(user)
    user == current_user
  end
  # make current_user? method available in other
  helper_method :current_user?
  
  # TODO isn't this an unneeded method / helper since @user.events would yeild the array of user events?
	protected
	def user_events(user)
    return Event.where(:user_id => user.id)
	end
	
	helper_method :user_events
	
	#filter method to enforce login requirement
	#apply as a before_filter on a any controller you want to protect
	def authenticate 
	  logged_in? ? true : access_denied
	end
	
	#predicate method for testing logged in user
	def logged_in?
	  current_user.is_a? User
	end
	
	#make logged_in? available in templates as a helper
	helper_method :logged_in?
	
  def find_event
    @event = Event.find(params[:event_id])
  end
  
  helper_method :find_event
	
	def access_denied
	  redirect_to login_path, :notice => "please login" and return false
	end
  
end
