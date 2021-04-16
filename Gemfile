# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby '2.5.3'

gem 'sinatra'
gem 'sendgrid-ruby'

group :development, :test do
  gem 'figaro', git: 'https://github.com/bpaquet/figaro.git', branch: 'sinatra'
  gem 'rspec'
end

group :test do
  gem 'minitest', '~> 5.8', '>= 5.8.4'
  gem 'rack-test'
  gem 'simplecov'
  gem 'webmock'
  gem 'vcr'
  gem 'capybara'
  gem 'pry'
end
