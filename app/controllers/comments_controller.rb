class CommentsController < ApplicationController

  before_filter :load_event, :except => :destroy
  before_filter :authenticate, :only => :destroy
  
  def create
    @comment = @event.comments.new(params[:comment])
	  if @comment.save
	  
  	  respond_to do |format|
  	    #@event, :notice => "thanks for the comment"
  	    format.html {redirect_to @event, :notice => "thanks for the comment"}
  		  format.js
  	  end
		
  	else 
  	  
  	  #redirect_to @event, :notice => "unable to post comment"
  	  respond_to do |format|
  	    format.html {redirect_to @event, :alert => "unable to comment"}
  		  format.js { render 'fail_create.js.erb'}
  	  end
  	  
  	end
  end
  
  def destroy 
    @event = current_user.events.find(params[:event_id])
    @comment = @event.comments.find(params[:id])
	  @comment.destroy
	
	
	redirect_to do |format|
	  format.html {redirect_to @event, :notice => "comment deleted"}
	  format.js
	end
	
end
  
  private 
    def load_event
	    @event = Event.find(params[:event_id])
	  end

end
