require 'simplecov'
SimpleCov.start

require 'rspec'
require 'rack/test'
# require 'webmock/rspec'
# require 'vcr'
#
# WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
#
# VCR.configure do |config|
#   config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
#   config.hook_into :webmock
#   config.filter_sensitive_data('sendgrid_api_key') { ENV['SENDGRID_API_KEY'] }
#   config.allow_http_connections_when_no_cassette = true
#   # config.default_cassette_options = { re_record_interval: 1.days }
# end
