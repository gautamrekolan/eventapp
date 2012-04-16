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
	
  def full_address
    "#{address} #{city} #{state} #{zip.to_s}"
  end
    
end
