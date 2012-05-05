class Place < ActiveRecord::Base
  
  validates :address, :presence => true
  validates :state, :presence => true
	validates :city, :presence => true
	validates :zip, :presence => true
	
	has_many :place_comments
	has_many :events
	# geocoder gem
	geocoded_by :full_address
	after_validation :geocode, :if => :address_changed?
	
	# this indexing must come after any associations
	# uses thinking sphinx and a running Sphinx daemon
	# define_index do
	  # indexes :username
	  # indexes :description
	# end
	
	def self.search_foursquare_venues(limit = 5, q = "")
	  url = "https://api.foursquare.com/v2/venues/search"
	  # location = "ll=40.7,-74"
	  # TODO update to reflect user's location
	  near = "near=" + CGI.escape("Ventura, Ca")
	  client_id = "client_id=#{SiteSettings::FOURSQUARE_CLIENT_ID}"
	  client_secret = "client_secret=#{SiteSettings::FOURSQUARE_CLIENT_SECRET}"
	  date = "v=20120429"
	  query = "&query=" + q
	  params = "?#{near}&#{client_id}&#{client_secret}&#{date}&limit=#{limit}"
    # "https://api.foursquare.com/v2/venues/search
    # if there was a query add it onto params	
    params = params + query unless query.empty?
    
    puts "#{url}#{params}"
    
    HTTParty.get "#{url}#{params}"
  end
	
  def full_address
    "#{address} #{city} #{state} #{zip.to_s}"
  end
    
end
