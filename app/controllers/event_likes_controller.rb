class EventLikesController < ApplicationController

  # for convenience and some encapsulation to define the @event variable globally
  before_filter :find_event
  
  def new 
    @like = @event.event_likes.new
    create
  end
  
  private
    def create 
      # add user id
      @like.user_id = current_user.id
      if @like.save 
      
        # create json response
        @likestring = "like " + @event.event_likes.count.to_s 
        @data = ActiveSupport::JSON.encode( { :message => @likestring.to_s })
        #puts "JSON =========== " + @data.to_s
      
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
          format.json { render :nothing => false }
        end
      end
    end
  
  def destroy
  
  end
  
  def show
  
  end 
  
  def like(event, user)
    
  end

end
