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
	  
    # "https://api.foursquare.com/v2/venues/search?ll=40.7,-74&client_id=#{SiteSettings::FOURSQUARE_CLIENT_ID}&client_secret=FOURSQUARE_CLIENT_SECRET&v=20120429"
	end
	
  def full_address
    "#{address} #{city} #{state} #{zip.to_s}"
  end
    
end
