require 'sinatra'
require 'sendgrid-ruby'
require 'bundler'
require 'figaro/sinatra'
Bundler.require

class SandgridApi < Sinatra::Base
include SendGrid

  post '/mail' do
    from = Email.new(email: params[:from])
    to = Email.new(email: params[:to])
    subject = params[:booking_name]
    content = Content.new(type: 'text/plain', value: params[:description])
    mail = Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
