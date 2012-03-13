require 'digest'

class User < ActiveRecord::Base

  attr_accessor :password 
  # for submissions from users/crop.html.erb cropping avatar etc
  attr_accessor :crop_x, :crop_y, :crop_h, :crop_w

  validates :email, :uniqueness => true,
    :length => { :within => 5..50 },
    :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }

  validates :password, :confirmation => true,
    :length => { :within => 4..20 },
	  :presence => true,
	  :if => :password_required?
	  
	validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :zip, :presence => true
  
  #has_one :profile, :dependent => :destroy
  has_many :events, :dependent => :destroy, :order => 'starttime ASC'
  #has_many :replies, :through => :events, :source => :comments
  has_many :going_tos, :dependent => :destroy #, :order => 'starttime ASC'
  has_many :comments, :dependent => :destroy
  has_many :place_comments, :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy
  has_many :followers, :through => :reverse_relationships
  has_many :following, :through => :relationships, :source => :followed
  
  before_save :encrypt_new_password
  
  # cropping images in crop.html.erb
  after_update :reprocess_avatar, :if => :cropping?

  # paperclip function to show that users have attached images
  has_attached_file :avatar, 
              :styles => { 
                :large => "500x500>", 
                :medium => "300x300>", 
                :thumb => "50x50>" }, 
                :processors => [:cropper],
               # tells paperclip how to crop the image  
              :storage => :s3,
              :s3_credentials => "#{Rails.root}/config/s3.yml",
              :path => ":attachment/:id/:style/:basename.:extension",
              :bucket => 'eventsbucket'
              
  
  #events the user is going to 
  #TODO probably should only return public events
  #def going_tos
  #  GoingTo.find_all_by_user_id(id)
  #end
  
  def username 
    # used to be a field in db username, but now we want firstname and last name
    "#{firstname} #{lastname}"
  end
  
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end
  
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
    relationships.find_by_followed_id(followed.id).destroy
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
	  return user if user && user.authenticated?(password)
  end
  
  def authenticated?(password)
    self.hashed_password == encrypt(password)
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
  
  # cropping avatar or other images in crop.html.erb
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank? 
  end

  def avatar_geometry(style = :original) 
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.to_file(style))
  end
  
  protected
  def encrypt_new_password
	  return if password.blank?
	  self.hashed_password = encrypt(password)
	end
  
  private
  def reprocess_avatar
    avatar.reprocess!
  end
  
end
