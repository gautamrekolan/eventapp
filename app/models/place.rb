class Place < ActiveRecord::Base
  
  
  validates :address, :presence => true
  validates :state, :presence => true
	validates :city, :presence => true
	validates :zip, :presence => true, :numericality => { :only_integer => true }
	

end
