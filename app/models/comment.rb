class Comment < ActiveRecord::Base


  validates :name, :presence => true
  validates :email, :presence => true
  validates :body, :presence => true
  #needs length check


  belongs_to :event

end
