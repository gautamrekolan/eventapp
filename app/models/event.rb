class Event < ActiveRecord::Base
	validates :name, :presence => true
	validates :starttime, :presence => true
	validates :endtime, :presence => true
	validates :location, :presence => true
	
	belongs_to :user
	has_and_belongs_to_many :categories
	has_many :comments
	
	
	def owned_by?(owner)
	  return false unless owner.is_a? User 
	  user == owner 
	end
	
	def published?
	  
	end
	
	def first_and_last
		"#{firstname} #{lastname}"
	end
end