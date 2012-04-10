class GoingTosController < ApplicationController
  
  before_filter :find_event
  # in application controller sets @event
  # DRY up the respond_to do |format| statements below
  
  respond_to :html, :js, :json
  
  def index 
    @going_tos = @event.going_tos
    
    # probably should sort this going_to array by time the user rsvp'd ex: @going_tos.sort! |going_to| { going_to.created_at }
    # TODO figure out how to sort these arrays
    # puts @going_tos.to_json
    respond_with @going_tos
  end
  
  def new 
    #@goingto = @event.going_tos.new
    #create
  end
  
  def create 
    @goingto.user_id = current_user.id
    if @goingto.save 
      
      # check if this is the only person going
      @going_to_count = @event.going_tos.count
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
      
      respond_with @data
      else
        respond_with @data
    end
  end
  
  def show 
    respond_with @event.going_tos.to_json
  end

end
