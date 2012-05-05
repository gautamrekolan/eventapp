require 'lib/railsutils/string_utils'

namespace :db do
  desc "Fill database with sample data" 
  task :populate => :environment do
    require 'ffaker' # moved inside task and namespace method because it chokes on heroku
    Rake::Task['db:reset'].invoke
    make_users
    make_places
    make_event_categories
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
    @username = StringUtils::random_string(8)
    @email = "example-#{n+1}@example.com" 
    @password = "password"
    @zip = Faker::Address.zip_code
    User.create!(:firstname => @firstname,
                     :lastname => @lastname, 
                     :username => @username,
                     :email => @email,
                     :password => @password,
                     :zip => @zip)
  end 
end


def make_places
  make_portland_places
  # 100.times do |n|
  #     # switch = n % 2
  #     @name = Faker::Lorem.word
  #     @address = Faker::Address.street_address
  #     @state = Faker::Address.us_state
  #     @city = Faker::Address.city
  #     @zip = Faker::Address.zip_code
  #     Place.create!(:name => @name,
  #                     :address => @address,
  #                     :state => @state,
  #                     :city => @city,
  #                     :zip => @zip)
  #   end
end

def make_portland_places 
  json_result = JSON.parse(open("#{Rails.root}/lib/tasks/places/places_portland_downtown_food.json").read)
  
  res = json_result["results"]
  
  res.each do |r|
     @name = r["name"]
     @address = r["vicinity"].split(",")[0]
     @state = "OR"
     @city = r["vicinity"].split(",")[1]
     @zip = "none"
     Place.create!(:name => @name,
                      :address => @address,
                      :state => @state,
                      :city => @city,
                      :zip => @zip)
  end
end

def make_event_categories 
  Category.create [ {:name => 'Sports'},
                    {:name => 'Arts and Entertainment'},
                    {:name => 'Music'},
                    {:name => 'Meeting'},
                    {:name => 'Hang out'},
                    {:name => 'Random'},
                    {:name => 'Conference'}]
end

def make_events
  make_events_this_week
  make_events_next_week
  # make_events_this_month
end

def make_events_today
  make_events_from_datetime(Time.now)
end

def make_events_tomorrow
  if Time.now.tomorrow.day == 1
    #do nothing because events next week will take care of it
  else
    make_events_from_datetime(Time.now.tomorrow)
  end
end

def make_events_this_week
  # make todays events, then we'll make the rest of the weeks events
  make_events_today
  
  # get the number of days left in the week
  number_of_days_left_in_the_week = 7 - Time.now.wday
  
  #iterate through each day and create events
  number_of_days_left_in_the_week.times do |n|
    days = n + 1
    make_events_from_datetime(Time.now + days.day)
  end
    
  # make_events_today
  # make_events_tomorrow
  # make_rest_of_the_week_events
end

def make_events_next_week
  next_week = Time.now.next_week # returns Monday Month # 00:00...
  
  7.times do |n|
    make_events_from_datetime(next_week + n.days)
  end
end

def make_events_this_month
  
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


private 
def make_events_from_datetime(time)
  categories = Category.all
  User.all(:limit => 20).each do |user|
    @accumulator = 1 # id's start with 1 not 0
    5.times do |n|
      # content = Faker::Lorem.sentence(5) user.microposts.create!(:content => content)
      @name = Faker::Lorem.sentence
      @starttime = time
      @endtime = time.to_time + 1.hours
      @user_id = user.id
      @description = Faker::Lorem.sentence(6)
      @place_id = @accumulator
      user.events.create!(:name => @name,
                          :starttime => @starttime,
                          :endtime => @endtime,
                          :user_id => @user_id,
                          :description => @description,
                          :place_id => @place_id,
                          :category_id => categories[rand(categories.count - 1)].id)
      
      if @accumulator > 19
        @accumulator = 1
      else
        @accumulator += 1
      end
    end 
  end
end