# Bundler, require default Gems
require 'bundler'
env = ENV['RACK_ENV'] || 'development'
Bundler.require :default, env

# Require app code
Dir['app/*.rb'].sort.each { |req| require_relative req }
Dir['config/initializers/*.rb'].sort.each { |req| require_relative req }
Dir['app/models/*.rb'].sort.each { |req| require_relative req }
Dir['app/routes/**/*.rb'].sort.each { |req| require_relative req }
