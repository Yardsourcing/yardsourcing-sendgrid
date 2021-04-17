require 'bundler'
require 'figaro/sinatra'
Bundler.require

# require File.expand_path('../config/environment',  __FILE__)

run Sinatra::Application
