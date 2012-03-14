require 'ffaker'

namespace :db do
  desc "Fill database with sample data" 
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_places
    make_events
    make_event_comments
    make_event_going_tos
    make_relationships
  end 
end

def make_users
  100.times do |n|
    @firstname = Faker::Name.first_name
    @lastname = Faker::Name.last_name
    @email = "example-#{n+1}@example.com" 
    @password = "password"
    @zip = Faker::Address.zip_code
    User.create!(:firstname => @firstname,
                     :lastname => @lastname, 
                     :email => @email,
                     :password => @password,
                     :zip => @zip)
  end 
end

def make_places
  100.times do |n|
    # switch = n % 2
    @name = Faker::Lorem.word
    @address = Faker::Address.street_address
    @state = Faker::Address.us_state
    @city = Faker::Address.city
    @zip = Faker::Address.zip_code
    Place.create!(:name => @name,
                    :address => @address,
                    :state => @state,
                    :city => @city,
                    :zip => @zip)
  end
end

def make_events
  User.all(:limit => 20).each do |user|
    @accumulator = 1 # id's start with 1 not 0
    5.times do |n|
      # content = Faker::Lorem.sentence(5) user.microposts.create!(:content => content)
      @name = Faker::Lorem.sentence
      @starttime = Time.now
      @endtime = Time.now
      @user_id = user.id
      @description = Faker::Lorem.sentence(6)
      @place_id = @accumulator
      user.events.create!(:name => @name,
                          :starttime => @starttime,
                          :endtime => @endtime,
                          :user_id => @user_id,
                          :description => @description,
                          :place_id => @place_id)
      
      @accumulator += 1
    end 
  end
end

def make_event_comments
end

def make_event_going_tos
end

def make_relationships 
  @users = User.all
  @user  = @users.first
  @following = @users[1..50]
  @followers = @users[3..40]
  @following.each { |followed| @user.follow!(followed) }
  @followers.each { |follower| follower.follow!(@user) }
end