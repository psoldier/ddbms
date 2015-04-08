require 'ost'
require 'sequel'
require 'mysql2'
require 'yaml'

Sequel.connect("mysql2://root:root@localhost/slave_1")
Dir[Dir.pwd + '/config/initializers/*.rb'].sort.each { |req| require_relative req }

class User < Sequel::Model
  set_primary_key [:id]
end

Ost["add_users_1"].each do |json|
  user = User.from_json(json)
  puts "Usuario id: " + user.id.to_s
  puts "Usuario name: " + user.name
  user.save(validate: false)
end
