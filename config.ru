require 'bundler'
require './config/environment'
# require './sendgrid_api'
Bundler.require

# require File.expand_path('../config/environment',  __FILE__)

run ApplicationController
