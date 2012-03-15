class EventsController < ApplicationController

  before_filter :authenticate, :except => [:index, :show, :notify_friend]
  
  respond_to :html, :js, :json, :xml
  # GET /events
  def index
    #puts "---------------" + request.location.country
    
    # get the user's address (city / state) from request
    # to create a map, also probably store that in the user's location
    if params[:city].blank?
      if logged_in?
        # has changed to zip and will probably change again
        @address = current_user.zip #"Ventura, CA" # the homeland
      else 
        # then we need to use a different technology for finding location
        # since the zip isn't available
        # @address = "not logged in"
        if Rails.env.production?
          @address = request.location.city + ", " + request.location.state
        else # we are in test or dev so we should fake city, state 
          # @address = "not logged in"
          @address = "93001" # request.location.city + ", " + request.location.state
        end
      end
    else 
      @address = params[:city]
    end
    
    @events = Event.find(:all, :limit => 50, :order => 'created_at DESC')
    
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

  def new
    @event = Event.new
    #@place = Place.new

    respond_with @event
  end

  # GET /events/1/edit
  def edit
    @event = current_user.events.find(params[:id])
  end

  def create
    set_start_end_datetimes
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
  
  private

  def set_start_end_datetimes
    # this adds the time onto the datetime object for convenience
    # in theory, there should always be a start time
    params[:event][:starttime] = params[:event][:starttime] + " " + full_start_time 
    if params[:event][:endtime].blank?
      # TODO not sure what to do here, error checking of some kind
    else
      params[:event][:endtime] = params[:event][:endtime] + " " + full_end_time
    end
  end
  
  def full_start_time
    # TODO it's possible this should only be done in the client
    if params[:starttime_ampm] == "PM"
      # then add 12 hours to it to format to the database
      # since we are using 12 hour time for american friends
      @hours = (params[:starttime_hour].to_i + 12).to_s 
    else
      @hours = params[:starttime_hour]
    end
    return @hours + ":" + params[:starttime_minute] + ":00"
  end
  
  def full_end_time
    # TODO it's possible this should only be done in the client
    if params[:endtime_ampm] == "PM"
      # then add 12 hours to it to format to the database
      # since we are using 12 hour time for american friends
      @hours = (params[:endtime_hour].to_i + 12).to_s 
    else
      @hours = params[:endtime_hour]
    end
    return @hours + ":" + params[:endtime_minute] + ":00"
  end
  
  def format_pm_hours
    
  end
end
