require './sendgrid_api'
require 'rack/test'

ENV['APP_ENV'] = 'test'

RSpec.describe SandgridApi do
include Rack::Test::Methods

  def app
    SandgridApi.new
  end

  it 'can send emails' do
    post '/mail?to=angelbreaux26@gmail.com&from=angelbreaux@hotmail.com&booking_name=BDAY BASH&description=You are Invited to my party!'
    expect(last_response.status).to eq(200)
  end
end
