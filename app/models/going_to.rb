class GoingTo < ActiveRecord::Base
  
  belongs_to :event
  
  def find_username 
    return User.find_by_id(user_id).username
  end
  
end
