require 'digest'
class User < ActiveRecord::Base

  attr_accessor :password 

  validates :email, :uniqueness => true,
    :length => { :within => 5..50 },
    :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }

  validates :password, :confirmation => true,
    :length => { :within => 4..20 },
	  :presence => true,
	  :if => :password_required?
	  
	validates :username, :uniqueness => true

  #has_one :profile, :dependent => :destroy
  has_many :events, :dependent => :destroy, :order => 'starttime ASC'
  #has_many :replies, :through => :events, :source => :comments
  has_many :going_tos, :dependent => :destroy #, :order => 'starttime ASC'
  has_many :comments, :dependent => :destroy
  has_many :place_comments, :dependent => :destroy
  before_save :encrypt_new_password
  
  #events the user is going to 
  #TODO probably should only return public events
  #def going_tos
  #  GoingTo.find_all_by_user_id(id)
  #end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
	  return user if user && user.authenticated?(password)
  end
  
  def authenticated?(password)
    self.hashed_password == encrypt(password)
  end
  
  protected
  def encrypt_new_password
	  return if password.blank?
	  self.hashed_password = encrypt(password)
	end
	
	def password_required?
	  hashed_password.blank? || password.present?
	end
	
	def encrypt(string)
	  Digest::SHA1.hexdigest(string)
	end
  
  def after_create
    puts "will send an email to the user later"
  end
end
