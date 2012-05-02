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
	def search_foursquare_venues
	  url = "https://api.foursquare.com/v2/venues/search"
	  location = "ll=40.7,-74"
	  client_id = "client_id=#{SiteSettings::FOURSQUARE_CLIENT_ID}"
	  client_secret = "client_secret=#{SiteSettings::FOURSQUARE_CLIENT_SECRET}"
	  params = "?#{location}&#{client_id}&&v=20120429"
    # "https://api.foursquare.com/v2/venues/search	
  end
	
  def full_address
    "#{address} #{city} #{state} #{zip.to_s}"
  end
    
end
