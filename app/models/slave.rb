# encoding: utf-8
class Slave < Sequel::Model
  set_primary_key [:id]

  def validate
    super
    validates_presence [:adapter, :host, :host_name, :host_password, :username, :password, :database, :master_host]
    validates_unique :database
  end

  def after_create
    super
    db.after_commit do
      environment = ENV['RACK_ENV'] || 'development'
      hash = YAML.load_file(Dir.pwd + '/config/database.yml')[environment]
      system("./create_slave.sh #{database} #{host_name} #{host} #{username} #{username} #{hash['database']} #{master_host}")
    end
    Ost["add_slaves"] << self.id
  end

end
