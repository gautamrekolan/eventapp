class CommentsController < ApplicationController

  before_filter :load_event #, :except => :destroy
  before_filter :authenticate #, :only => :destroy
  # TODO this needs validations, all model classes need validations
  
  def create
    @comment = @event.comments.new(params[:comment])
    @comment.user_id = current_user.id
	  if @comment.save
	  
  	  respond_to do |format|
  	    #@event, :notice => "thanks for the comment"
  	    format.html { redirect_to @event, :notice => "thanks for the comment"}
  		  format.js { render 'create.js.erb'}
  	  end
		
  	else 
  	  
  	  #redirect_to @event, :notice => "unable to post comment"
  	  respond_to do |format|
  	    format.html { redirect_to @event, :alert => "unable to comment" }
  		  format.js { render 'fail_create.js.erb'}
  	  end
  	  
  	end
  end
  
  def destroy 
    # @event = current_user.events.find(params[:event_id])
    # event doesn't necessarily have to belong to a user, could be the own of the event or user who posted the evnet
    
    @comment = @event.comments.find(params[:id])
	  @comment.destroy
	  # puts "CCCOOOOOMMMENT " + @comment.body + " format "
	  
	  respond_to do |format|
  	  format.html { redirect_to @event, :notice => "comment deleted" }
  	  format.js { render 'destroy.js.erb' }
  	end
	
  end
  
  private 
    def load_event
	    @event = Event.find(params[:event_id])
	  end

end
