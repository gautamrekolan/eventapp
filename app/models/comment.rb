class Comment < ActiveRecord::Base


  #validates :name, :presence => true
  #validates :email, :presence => true
  #ditched these attributes
  
  validates :body, :presence => true
  validates :user_id, :presence => true
  #needs length check


  belongs_to :event
  belongs_to :user
  
  def owned_by?(owner)
	  return false unless owner.is_a? User 
	  puts " " + owner.id.to_s
	  user == owner 
	end

end
