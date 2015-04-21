require 'ost'
require 'sequel'
require 'mysql2'
require 'yaml'

Sequel.connect("mysql2://root:root@localhost/slave_3")
Ost.redis = Redic.new("redis://127.0.0.1:6379")

Dir[Dir.pwd + '/config/initializers/*.rb'].sort.each { |req| require_relative req }

class User < Sequel::Model
  set_primary_key [:id]
end

Ost["destroy_users_3"].each do |id|
  user = User[id]
  puts "Usuario id: " + user.id.to_s
  puts "Usuario name: " + user.name
  user.delete
end
