# encoding: utf-8

class User < Sequel::Model
  include Shield::Model
  set_primary_key [:id]

  def validate
    super
    validates_presence :username
    validates_unique :username
  end

  def after_create
    super
    db.after_commit do
      Slave.all.each do |slave|
        Ost["add_users_" + slave.id.to_s] << self.to_json
      end
    end
  end

  #def to_json
  #  { id: self.id, name: self.name, username: self.username, admin: self.admin, password: "1234" }.to_json
  #end

  def self.fetch(username)
    first(username: username)
  end

end
