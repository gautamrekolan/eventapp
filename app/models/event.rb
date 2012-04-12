class Event < ActiveRecord::Base
  
	validates :name, :presence => true, :length => { :minimum => 2,
	                                                  :maximum => 100 }
	validates :starttime, :presence => true #, :datetime_format => true
	#validate  :starttime_valid? => true
	#validates :endtime, :presence => true
	#validate  :endtime_valid? => true, :end_date_after_start_date => true
	validates :description, :presence => true, :length => { :minimum => 20,
	                                                        :maximum => 1000}
	has_one :place
	belongs_to :user
	# has_and_belongs_to_many :categories
	belongs_to :category
	has_many :comments
	#has_many :event_likes
	has_many :going_tos
	
	# scopes
	scope :section_formatted, order('starttime DESC').limit(8)
	
	# this indexing must come after any associations
	# uses thinking sphinx and a running Sphinx daemon
	define_index do
	  indexes :name
	  indexes :description
	end
	
	def find_all_gone_to_by_user_id(id)
	  Event.find(:all, :where => "starttime < #{ Time.now }", :user_id => id)
	end
	
	def owned_by?(owner)
	  return false unless owner.is_a? User 
	  user == owner 
	end
	
	def going?(user)
	  # puts user.id.to_s
	  going_tos.find_all_by_user_id(user.id).count > 0
	  # return false #
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
	
	def self.get_events_by_day(day)
	  #debugger
	  Event.where('starttime BETWEEN ? AND ?', day.beginning_of_day, day.end_of_day)
	end
	
	def self.featured
	  Event.where('starttime > ?', Time.now.utc.beginning_of_day).order('starttime DESC').limit(5)
	end
	
	def self.today 
	  Event.where('starttime BETWEEN ? AND ?', Time.now.utc.beginning_of_day, Time.now.utc.end_of_day)
	end
	
	def self.tomorrow
	  Event.where('starttime BETWEEN ? AND ?', (Time.now + 1.day).beginning_of_day, (Time.now + 1.day).end_of_day)
	end
end
