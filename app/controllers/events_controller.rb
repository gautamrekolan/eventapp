class EventsController < ApplicationController

  before_filter :authenticate, :except => [:index, :search, :show, :notify_friend]
  
  respond_to :html, :js, :json, :xml
  
  def tickets 
    @event = Event.find(params[:id])
  end 
  
  def search 
      @search_q = params[:query]
      limit = 4
      # TODO simplify these queries by moving them into models and more intuitively naming the method
      @events = Event.find(:all, :conditions => ["lower(name) LIKE ?", (@search_q + "%").downcase], :limit => limit) #{}"name LIKE lower(" + @search_q + "%)").limit(limit) #Event.search @search_q, :limit => limit #, :retry_stale => true
      # @places = Place.search @search_q, :limit => limit
      @places = Place.search_foursquare_venues(limit, @search_q)
      @users = User.find(:all, :conditions => ["lower(username) LIKE ?", (@search_q + "%").downcase], :limit => limit) # where("username LIKE ?", @search_q + "%").limit(limit)  # @search_q, :limit => limit
      
      respond_with ({ :events => @events, :users => @users, :places => @places })
  end
  
  # GET /events
  def index
    
    # get current user location
    @address = get_address
    
    # @places_near = Place.near(@address, 10, :order => :distance)
    
    @events_array = Array.new
    #@events_array.push(Event.today.section_formatted)
    #@events_array.push(Event.tomorrow.section_formatted)
    
    # get the rest of the days events
    # TODO move to function somewhere else
    7.times do |n|
      day = Time.now + (n).days
      events_hash = Hash.new
      events = Event.get_events_by_day(day).section_formatted
      if n == 0 && events.count > 0
        events_hash["today"] = events
      elsif n == 1 && events.count > 0
        events_hash["tomorrow"] = events
      else
        if events.count > 0
          str = events.first.starttime.strftime("%A, %b %d")
          events_hash[str] = events
        end
      end
      @events_array.push(events_hash)
    end  
    
    respond_with @events_array #@event_sections
    # respond_with @events_today
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
  
  def get_address
    # get the user's address (city / state) from request
    # to create a map, also probably store that in the user's location
    if params[:city].blank?
      if logged_in?
        # has changed to zip and will probably change again
        return current_user.zip #"Ventura, CA" # the homeland
      else 
        # then we need to use a different technology for finding location
        # since the zip isn't available
        # @address = "not logged in"
        if Rails.env.production?
          return request.location.city + ", " + request.location.state
        else # we are in test or dev so we should fake city, state 
          # @address = "not logged in"
          return "93001" # request.location.city + ", " + request.location.state
        end
      end
    else 
      return params[:city]
    end
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
