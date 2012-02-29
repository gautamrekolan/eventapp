class Place < ActiveRecord::Base
  
  
  validates :address, :presence => true
  validates :state, :presence => true
	validates :city, :presence => true
	validates :zip, :presence => true, :numericality => { :only_integer => true }
	
	has_many :place_comments
	
  def full_address
    "#{address} #{city} #{state} #{zip.to_s}"
  end
    
end
