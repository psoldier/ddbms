# encoding: utf-8
class Slave < Sequel::Model
  set_primary_key [:id]

  def validate
    super
    validates_presence [:adapter, :host, :username, :password, :database]
    validates_unique :database
  end

  def after_create
    super
    db.after_commit do
      environment = ENV['RACK_ENV'] || 'development'
      hash = YAML.load_file(Dir.pwd + '/config/database.yml')[environment]
      dump_file_path = Dir.pwd + "/dumps/dump_#{SecureRandom.hex}.sql"

      system("mysqldump -u#{hash['username']} -p#{hash['password']} #{hash['database']} > #{dump_file_path}")

      db = Sequel.connect("mysql2://#{self.username}:#{self.password}@#{self.host}")
      db.run("CREATE DATABASE #{self.database}")

      system("mysql -u#{self.username} -p#{self.password} #{self.database} < #{dump_file_path}")
    end
  end

end
