require './sendgrid_api'
require 'rack/test'
require 'spec_helper'

ENV['APP_ENV'] = 'test'

RSpec.describe SandgridApi, type: :request do
include Rack::Test::Methods

  def app
    SandgridApi.new
  end

  it 'can send emails' do
    VCR.use_cassette('send_message') do
      post '/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&booking_name=BDAY BASH&description=You are Invited to my party!'

      expect(last_response.status).to eq(200)
    end
  end
end
