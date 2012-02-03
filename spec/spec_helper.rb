require 'rubygems'
require 'bundler'
require 'bundler/setup'

Bundler.require :default, :development

require 'machinist'
require 'machinist/mongoid'

Combustion.initialize! :action_controller, :action_view, :sprockets, :action_mailer
ActiveSupport::Dependencies.log_activity = true

require 'rspec/rails'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :mocha
  config.include Mongoid::Matchers
  config.after :suite do
    Mongoid.master.collections.select do |collection|
      collection.name !~ /system/
    end.each(&:drop)
  end
end