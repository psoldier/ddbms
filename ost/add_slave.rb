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

class Slave < Sequel::Model; end

Ost["add_slaves"].each do |id|
  Slave.db = Sequel.connect("mysql2://#{hash['username']}:#{hash['password']}@#{hash['host']}/#{hash['database']}")
  params = Hash.new
  Slave[id].each{|k,v|params["#{k}"] = "#{v}"}
  s = Slave.new(params)

  slaves = Slave.all
  slaves.pop
  # retiro el último slave para no cargar 2 registros
  slaves.each do |slave|
    # configuro la coneccion del slave en donde quiero agregar esta informacion
    Slave.db = Sequel.connect(:adapter=>slave.adapter, :host=>slave.host, :database=>slave.database, :user=>slave.username, :password=>slave.password, :port=>'3306')
    s.save
    puts "Se agrego el slave #{s.database} en el Slave: #{slave.database}"
  end
end