class PlaceComment < ActiveRecord::Base
  
  validates :body, :presence => true
  validates :user_id, :presence => true
  
  belongs_to :place
  belongs_to :user
  
  def find_user
    User.find(user_id)
  end
  
end
