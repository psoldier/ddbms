# encoding: utf-8

class User < Sequel::Model
  include Shield::Model
  set_primary_key [:id]

  def validate
    super
    validates_presence :username
    validates_unique :username
  end
  
  def self.fetch(username)
    first(username: username)
  end

end
