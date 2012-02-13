class Event < ActiveRecord::Base
  
	validates :name, :presence => true, :length => { :minimum => 2,
	                                                  :maximum => 100 }
	validates :starttime, :presence => true
	validate  :starttime_valid? => true
	validates :endtime, :presence => true
	validate  :endtime_valid? => true, :end_date_after_start_date => true
	validates :location, :presence => true
	validates :description, :presence => true
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
	
	private
	def starttime_valid?
	  if !is_valid_date_format?(:starttime)
	    errors.add(:starttime, "start date / time not valid")
	  end
	end
	
	private
	def endtime_valid?
	  if !is_valid_date_format?(:endtime)
	    errors.add(:endtime, "start date / time not valid")
	  end 
	end
	
	private
  def is_valid_date_format?
    begin 
      dt = DateTime.parse(date)
      return true
    rescue
      # add error to 
      return false
    end
  end
  
  private
  def end_date_after_start_date?
    if !endtime.blank? and !starttime.blank?
      if endtime < starttime
        errors.add(:endtime, "end time must be later than start time")
      end
    end
  end
	
	def published?
	  
	end
	
	def first_and_last
		"#{firstname} #{lastname}"
	end
end
