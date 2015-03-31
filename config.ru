# encoding: utf-8

require './init'

run Rack::URLMap.new(
  '/'                 => DBMS::PublicApp.new,
  '/admin/'           => DBMS::AdminApp.new
)
