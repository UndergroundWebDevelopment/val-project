ENV["RACK_ENV"] ||= "development"

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, ENV["RACK_ENV"])

require 'json'
require "trailblazer/autoloading"
require "reform/form/dry"
require "reform/form/coercion"
require 'representable/json'
require 'roar/json/json_api'

module ValProject
  DB = if ENV.key? "DATABASE_URL"
         Sequel.connect(ENV["DATABASE_URL"])
       else
         db_user = ENV["DATABASE_USER"] || ENV["USER"] 
         db_pw = ENV["DATABASE_PASSWORD"] || nil
         Sequel.connect("postgres://localhost/#{ENV["RACK_ENV"]}", user: db_user, password: db_pw)
       end
end
