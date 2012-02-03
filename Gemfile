source "http://rubygems.org"

gem 'combustion', '~> 0.3.1', :group => :development
gem 'transit', :path => File.expand_path("../../engine", __FILE__)

group :test do
  gem 'rake'
  gem 'growl'
  gem 'guard', '0.8.8'
  gem "guard-rspec"
  gem 'machinist_mongo', git: "git://github.com/nmerouze/machinist_mongo.git", branch: "machinist2", require: "machinist/mongoid"
end

# Specify your gem's dependencies in transit.gemspec
gemspec
