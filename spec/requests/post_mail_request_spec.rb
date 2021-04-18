require 'rack/test'
require 'spec_helper'
require './app/controllers/application_controller'

ENV['APP_ENV'] = 'test'

RSpec.describe ApplicationController, type: :request do
include Rack::Test::Methods

  def app
    ApplicationController
  end

  describe "Happy path" do
    it 'can send emails' do
      VCR.use_cassette('send_email') do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&subject=BDAY BASH&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(202)
        expect(body[:message]).to eq("Message sent sucscessfully")
      end
    end
  end

  describe "Sad path" do
    describe "returns a 400 error if params are missing" do
      it "must have a sender" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&subject=BDAY BASH&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "sender cannot be blank" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=&subject=BDAY BASH&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "must have a recipient" do
        post '/api/v1/mail?from=doug.welchons@gmail.com&subject=BDAY BASH&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "recipient cannot be blank" do
        post '/api/v1/mail?to=&from=doug.welchons@gmail.com&subject=BDAY BASH&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "must have a subject" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "subject cannot be blank" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&subject=&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end
      it "must have content" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&subject=BDAY BASH'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "content cannot be blank" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&subject=BDAY BASH&content='
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end
    end
  end
end
