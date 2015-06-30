require 'ost'
require 'sequel'
require 'yaml'

#environment = ENV['RACK_ENV'] || 'development'
#hash = YAML.load_file(root + '/config/database.yml')[environment]
#db = Sequel.connect("mysql2://#{hash['username']}:#{hash['password']}@#{hash['host']}/#{hash['database']}")

Sequel.connect(:adapter=>'mysql2', :host=>'192.168.56.102', :database=>'slave', :user=>'root', :password=>'root', :port=>'3306')
Ost.redis = Redic.new("redis://127.0.0.1:6379")

Dir[Dir.pwd + '/config/initializers/*.rb'].sort.each { |req| require_relative req }

class User < Sequel::Model
  set_primary_key [:id]
end

Ost["destroy_users"].each do |id|
  user = User[id]
  puts "Usuario id: " + user.id.to_s
  puts "Usuario name: " + user.name
  user.delete
end
