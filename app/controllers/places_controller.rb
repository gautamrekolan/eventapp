class PlacesController < ApplicationController
  
  respond_to :html, :js, :json
  
  def new 
    @place = Place.new
    
    respond_with @place
  end
  
  def show
    @place = Place.find(params[:id])
    
    #show events that are at this place
    @events = Event.find_all_by_place_id(params[:id])
    
    respond_with @place
  end
  
  def index 
    #think of a clever way to show places 
    @places = Place.all
    
    respond_with @place
  end
  
  def create
    #think of a clever way to add places
    #may not need to add places since they are added in events
  end
  
end
