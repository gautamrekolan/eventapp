class EventsController < ApplicationController

  before_filter :authenticate, :except => [:index, :show, :notify_friend]
  
  respond_to :html, :js, :json, :xml
  # GET /events
  def index
    #puts "---------------" + request.location.country
    
    # get the user's address (city / state) from request
    # to create a map, also probably store that in the user's location
    @address = request.location.city + ", " + request.location.state
    
    @events = Event.all
    
    respond_with @events
  end

  # GET /events/1
  def show
    
    @event = Event.find(params[:id])
    
    if @event.place?
      @place = @event.place
    end
    
    respond_with @event
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    #@place = Place.new

    respond_with @event
  end

  # GET /events/1/edit
  def edit
    @event = current_user.events.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    
    @event = current_user.events.new(params[:event])
    @place = Place.new(params[:place])
    
    if @event.valid? && @place.valid?
      
      # event.place_id = place
      @place.save # needs to save before event so it can have an id
      @event.place_id = @place.id
      @event.save 
      
      
      respond_with @event
    else 
      respond_with(@event) do |format| 
        format.html { render :new }
      end
    end
    
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = current_user.events.find(params[:id])

    respond_with @events
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy
    # TODO error handling on destroy
    respond_with @events
  end
  
  def notify_friend
    @event = Event.find(params[:id])
	  Notifier.email_friend(@event, params[:name], params[:email]).deliver 
	  redirect_to @event, :notice => "message sent successfully"
  end
  
end
