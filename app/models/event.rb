class Event < ActiveRecord::Base
  
	validates :name, :presence => true, :length => { :minimum => 2,
	                                                  :maximum => 100 }
	validates :starttime, :presence => true #, :datetime_format => true
	#validate  :starttime_valid? => true
	validates :endtime, :presence => true
	#validate  :endtime_valid? => true, :end_date_after_start_date => true
	validates :description, :presence => true, :length => { :minimum => 20,
	                                                        :maximum => 1000}
	has_one :place
	belongs_to :user
	#has_and_belongs_to_many :categories
	has_many :comments
	#has_many :event_likes
	has_many :going_tos
	
	# this indexing must come after any associations
	# uses thinking sphinx and a running Sphinx daemon
	define_index do
	  
	end
	
	def owned_by?(owner)
	  return false unless owner.is_a? User 
	  user == owner 
	end
	
	def going?(user)
	  #puts user.id.to_s
	  going_tos.find_all_by_user_id(user.id).count > 0
	  #return false #
	end
	
	def liked_by?(owner)
	  if event_likes.find_by_user_id(owner.id)
    end
	end
	
	def place 
    return Place.find(place_id)
  end
  
  def place?
    return true unless !place_id?
  end
	
	def published?
	  
	end
	
	def first_and_last
		"#{firstname} #{lastname}"
	end
end
