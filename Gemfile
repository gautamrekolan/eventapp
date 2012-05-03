source 'http://rubygems.org'

gem 'rails', '3.2.0'

gem 'httparty'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# using post
# gem 'sqlite3'
# postgres
gem 'pg'

# thin is faster and everybody else thinks it's cool, so i think it's cool
gem 'thin' # this breaks everything 

# this could be installed as a "plugin"
# but supposedly gemfile is where all the app dependencies go
gem 'thinking-sphinx', '2.0.10' 
# this is required for heroku 'flying sphinx' which is a heroku add-on for thinking sphinx support
# gem 'flying-sphinx',   '0.6.4' 
# trying github repo to see if it resolves multi_json dependency
gem 'flying-sphinx', :git => 'git://github.com/flying-sphinx/flying-sphinx.git'

# geocoding library for rails 3 - uses google maps default http://rubygeocoder.com/
gem 'geocoder'

# paperclip for file attachments
gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"

# amazon aws for use with paperclip
# didn't use 'aws-s3' because i read that this is more extensive for multiple languages
gem 'aws-sdk' 

gem 'rake', '>= 0.9.2.2'
gem 'rdoc', '~>3.12' 

# this was originally in group dev but i need to run in production to get others to see the app
gem 'ffaker', '~> 1.13.0'

# development specific gems
group :development do
	gem 'ruby-debug'
end

# directions found here: http://www.rubyinside.com/how-to-rails-3-and-rspec-2-4336.html
group :development, :test do
  gem 'rspec-rails'
end

# asset pipeline
group :assets do
  gem 'sass-rails' #, "~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', ">= 1.0.3"
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
