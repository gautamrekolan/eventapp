class Event < ActiveRecord::Base
  
	validates :name, :presence => true, :length => { :minimum => 2,
	                                                  :maximum => 100 }
	validates :starttime, :presence => true #, :datetime_format => true
	#validate  :starttime_valid? => true
	validates :endtime, :presence => true
	#validate  :endtime_valid? => true, :end_date_after_start_date => true
	validates :location, :presence => true, :length => { :minimum => 2,
	                                                     :maximum => 100}
	validates :description, :presence => true, :length => { :minimum => 20,
	                                                        :maximum => 1000}
	validates :state, :presence => true
	validates :city, :presence => true
	validates :zip, :presence => true, :numericality => { :only_integer => true }
	
	belongs_to :user
	has_and_belongs_to_many :categories
	has_many :comments
	has_many :event_likes
	has_many :going_to
	
	def owned_by?(owner)
	  return false unless owner.is_a? User 
	  user == owner 
	end
	
	def going?(owner)
	  if going_to.find_by_user_id(owner.id)
	  end
	end
	
	def liked_by?(owner)
	  if event_likes.find_by_user_id(owner.id)
    end
	end
	
	def published?
	  
	end
	
	def first_and_last
		"#{firstname} #{lastname}"
	end
end
