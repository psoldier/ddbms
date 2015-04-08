require 'ost'
require 'sequel'
require 'mysql2'
require 'yaml'

Sequel.connect("mysql2://root:root@localhost/slave_3")
Dir[Dir.pwd + '/config/initializers/*.rb'].sort.each { |req| require_relative req }

class User < Sequel::Model
  set_primary_key [:id]
end

Ost["update_users_3"].each do |json|
  params = Hash.new
  user = User.from_json(json)
  user.each{|k,v|params["#{k}"] = "#{v}"}
  id = params.delete("id")

  @user = User[id]
  @user.update params

  puts "Usuario id: " + @user.id.to_s
  puts "Usuario name: " + @user.name
end
