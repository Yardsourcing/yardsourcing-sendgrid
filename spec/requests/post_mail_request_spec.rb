require 'rack/test'
require 'spec_helper'
require './app/controllers/application_controller'

ENV['APP_ENV'] = 'test'

RSpec.describe ApplicationController, type: :request do
include Rack::Test::Methods

  def app
    ApplicationController
  end

  it 'can send emails' do
    VCR.use_cassette('send_email') do
      post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&subject=BDAY BASH&content=You are Invited to my party!'
      body = JSON.parse(last_response.body, symbolize_names: true)

      expect(last_response.status).to eq(202)
      expect(body[:message]).to eq("Message sent sucscessfully")
    end
  end
end
