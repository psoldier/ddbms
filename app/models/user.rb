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

  def after_update
    super
    db.after_commit do
      Slave.all.each do |slave|
        Ost["update_users_" + slave.id.to_s] << self.to_json
      end
    end
  end

  def before_destroy
    super
    Slave.all.each do |slave|
      Ost["destroy_users_" + slave.id.to_s] << self.id
    end
  end

  def self.fetch(username)
    first(username: username)
  end

end
