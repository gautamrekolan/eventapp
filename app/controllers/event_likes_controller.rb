class EventLikesController < ApplicationController

  # for convenience and some encapsulation to define the @event variable globally
  before_filter :find_event
  
  def new 
    
    @like = @event.event_likes.build
    @like.user_id = params[:user_id]
    @like.event_id = @event.id
    @like.save
    
    puts "LIKE ID ======== " + @like.user_id.to_s
    puts "LIKE EVENT ID ======= " + @like.event_id.to_s
    # dubug @like
    respond_to do |format|
      format.html
      format.xml 
      format.js { render :nothing => true }
    end
  end
  
  def create 
    @like = @event.event_likes.build
  end
  
  def destroy
  
  end
  
  private 
    def find_event 
      @event = Event.find(params[:event_id])
    end
  
  def show
  
  end 
  
  def like(event, user)
    
  end

end
