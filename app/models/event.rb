class Event < ActiveRecord::Base
  
	validates :name, :presence => true
	validates :starttime, :presence => true
	# validates :endtime, :presence => true
	validates :location, :presence => true
	
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
	    return true
	  else 
	    return false
	  end
	end
	
	def liked_by?(owner)
	  if event_likes.find_by_user_id(owner.id)
	    return true
	  else
	    return false
    end
	end
	
	def published?
	  
	end
	
	def first_and_last
		"#{firstname} #{lastname}"
	end
end
