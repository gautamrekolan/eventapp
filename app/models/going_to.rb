class GoingTo < ActiveRecord::Base
  
  belongs_to :event
  belongs_to :user
  
  def find_username 
    return User.find_by_id(user_id).username
  end
  
  def find_user
    return User.find(user_id)
  end
  
end
