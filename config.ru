require 'bundler'
require './sendgrid_api'
Bundler.require

# require File.expand_path('../config/environment',  __FILE__)

run Sinatra::Application
