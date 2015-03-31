require 'rake/testtask'
require './init.rb'
require './app/_base'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.libs << 'spec'
  t.pattern = 'test/**/*.rb'
  t.verbose = true
end

namespace :db do
  desc 'Create database'
  task :create do
    environment = ENV['RACK_ENV'] || 'development'
    hash = YAML.load(File.new('./config/database.yml'))[environment]
    db = Sequel.connect("mysql2://#{hash['username']}:#{hash['password']}@#{hash['host']}")
    db.run("CREATE DATABASE #{hash['database']}")
  end

  desc 'Run database migrations'
  task :migrate do
    Sequel.extension :migration
    Sequel::Migrator.apply(DBMS::Base::DB, 'db/migrations')
  end

  desc "Nuke the database (drop all tables)"
  task :drop do
    environment = ENV['RACK_ENV'] || 'development'
    hash = YAML.load(File.new('./config/database.yml'))[environment]
    DBMS::Base::DB.run("DROP DATABASE IF EXISTS #{hash['database']}")
  end

  desc "Reset the database"
  task :reset => [:nuke, :migrate]

  desc "Seeds"
  task :seeds do
    require './db/seeds'
  end

end

desc 'Start a console'
task :console do
  ENV['RACK_ENV'] ||= 'development'
  %w(irb irb/completion).each { |r| require r }
  require_relative 'init'

  ARGV.clear
  IRB.start
end

desc 'Run tests'
task :default => :test
