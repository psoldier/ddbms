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
    Ost["add_users"] << self.id
  end

  def after_update
    super
    Ost["update_users"] << self.id
  end

  def before_destroy
    super
    Ost["destroy_users"] << self.id
  end

  def self.fetch(username)
    first(username: username)
  end

end
