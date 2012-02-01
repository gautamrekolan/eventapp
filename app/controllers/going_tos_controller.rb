class GoingTosController < ApplicationController
  
  before_filter :find_event
  # in application controller sets @event
  
  def index 
    @going_tos = @event.going_to
    
    # probably should sort this going_to array by time the user rsvp'd ex: @going_tos.sort! |going_to| { going_to.created_at }
    # TODO figure out how to sort these arrays
    
    respond_to do |format|
      format.html
      format.xml
    end
    
  end
  
  def new 
    @goingto = @event.going_to.new
    create
  end
  
  def create 
    @goingto.user_id = current_user.id
    if @goingto.save 
      
      # check if this is the only person going
      @going_to_count = @event.going_to.count
      if @going_to_count == 1
        @goingtostring = "you're going!"
      else
        # subtract "you = 1"
        @going_to_count = @going_to_count - 1;
        if @going_to_count == 2
          @goingtostring = "you & #{@going_to_count} other are going"
        else 
          @goingtostring = "you & #{@going_to_count} others are going"
        end
      end
      @data = ActiveSupport::JSON.encode( { :message => @goingtostring.to_s } )
      
      respond_to do |format|
        format.html
        format.xml
        format.js { render :nothing => true }
        format.json { render :json => @data.to_json }
      end
    else
      respond_to do |format|
        format.html
        format.xml
        format.js { render :nothing => false }
        format.json { render :json => false }
      end
    end
  end
  
  def show 
    respond_to do |format|
      format.html render @event.going_to
      format.xml
    end
  end

end
