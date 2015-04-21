require 'ost'
require 'sequel'

Sequel.connect(:adapter=>'mysql2', :host=>'192.168.56.102', :database=>'slave', :user=>'root', :password=>'root', :port=>'3306')
Ost.redis = Redic.new("redis://127.0.0.1:6379")

Dir[Dir.pwd + '/config/initializers/*.rb'].sort.each { |req| require_relative req }

class User < Sequel::Model
  set_primary_key [:id]
end

Ost["update_users"].each do |json|
  params = Hash.new
  user = User.from_json(json)
  user.each{|k,v|params["#{k}"] = "#{v}"}
  id = params.delete("id")

  @user = User[id]
  @user.update params

  puts "Usuario id: " + @user.id.to_s
  puts "Usuario name: " + @user.name
end
