require 'rack/test'
require 'spec_helper'
require './app/controllers/application_controller'
require 'pry'

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
        expect(body[:message]).to eq("Message sent successfully")
      end
    end
  end

  describe "Sad path" do
    describe "returns a 400 error" do
      it "when 'from' email is not included" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&subject=BDAY BASH&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "when 'from' email address is not proper email format" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreauxhotmail.com&subject=BDAY BASH&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "when 'from' email is an empty string" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=&subject=BDAY BASH&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "when 'to' email is missing" do
        post '/api/v1/mail?from=doug.welchons@gmail.com&subject=BDAY BASH&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "when 'to' email is an empty string" do
        post '/api/v1/mail?to=&from=doug.welchons@gmail.com&subject=BDAY BASH&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "when 'to' email address is not proper email format" do
        post '/api/v1/mail?to=doug.welchons.gmail.com&from=angelbreaux@hotmail.com&subject=BDAY BASH&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "when 'subject' is missing" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "when 'subject' is an empty string" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&subject=&content=You are Invited to my party!'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "when 'content' is missing" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&subject=BDAY BASH'
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end

      it "when 'content' is an empty string" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&subject=BDAY BASH&content='
        body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("There was an error proccessing your request")
      end
    end

    describe 'edge case' do
      xit "returns a 400 error when sendgrid api does not respond with 202" do
        post '/api/v1/mail?to=doug.welchons@gmail.com&from=angelbreaux@hotmail.com&subject=BDAY BASH&content=You are Invited to my party!'

        response = stub(SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
          .client.mail._('send').post)
          .to_return(status: 500, headers: {})
        # body = JSON.parse(last_response.body, symbolize_names: true)

        expect(last_response.status).to eq(400)
        expect(body[:message]).to eq("Message sent successfully")
      end
    end
  end
end
