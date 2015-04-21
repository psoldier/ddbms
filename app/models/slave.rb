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

      system("echo 'create database #{self.database}' | ssh slave@#{self.host} mysql -u #{self.username} -p#{self.password}")
      system("mysqldump #{hash['database']} | sshpass -p slave ssh slave@#{self.host} mysql #{self.database}")

    end
  end

end
