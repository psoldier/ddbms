require 'ost'
require 'sequel'
require 'yaml'

# ost
Ost.redis = Redic.new("redis://127.0.0.1:6379")

# sequel
environment = ENV['RACK_ENV'] || 'development'
hash = YAML.load_file(Dir.pwd + '/config/database.yml')[environment]
Sequel.connect("mysql2://#{hash['username']}:#{hash['password']}@#{hash['host']}/#{hash['database']}")
Dir[Dir.pwd + '/config/initializers/*.rb'].sort.each { |req| require_relative req }

class User < Sequel::Model; end
class Slave < Sequel::Model; end


Ost["destroy_users"].each do |id|
  Slave.all.each do |slave|
    # configuro la coneccion del slave en donde quiero agregar esta informacion
    User.db = Sequel.connect(:adapter=>slave.adapter, :host=>slave.host, :database=>slave.database, :user=>slave.username, :password=>slave.password, :port=>'3306')
    user = User[id]
    user.delete
    puts "Se elimino el usuario #{user.name} en el Slave: #{slave.database}"
  end
end