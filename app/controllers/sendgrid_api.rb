require 'sinatra'
require 'bundler'
require 'sendgrid-ruby'
require 'figaro/sinatra'
require 'sinatra/json'
require "sinatra/jsonp"
require "sinatra/namespace"
Bundler.require

class SandgridApi < Sinatra::Base
include SendGrid

  before do
    content_type 'application/json'
  end

  post '/mail' do
    from = Email.new(email: params[:from])
    to = Email.new(email: params[:to])
    subject = params[:booking_name]
    content = Content.new(type: 'text/plain', value: params[:description])
    mail = Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    if response.status_code == "202"
      data = {message: "Message sent sucscessfully"}
    else
      data = {message: "There was an error proccessing your request"}
    end
    data.to_json
  end


  # post '/mail' do
  #   # from = Email.new(email: params[:from])
  #   # to = Email.new(email: params[:to])
  #   # subject = params[:booking_name]
  #   # content = Content.new(type: 'text/plain', value: params[:description])
  #   # mail = Mail.new(from, subject, to, content)
  #   # sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  #   # response = sg.client.mail._('send').post(request_body: mail.to_json)
  #   response = send_mail
  #   require "pry"; binding.pry
  #   # JSONP response
  #   # if response.status_code == "202"
  #   #   "Message sent sucscessfully".to_json
  #   #   # js :file
  #   # else
  #   #   render json: {error: "There was an aeror proccessing your request"}, status: :bad_request
  #   #   # puts "There was an aeror proccessing your request"
  #   # end
  # end
  #
  #
  # def send_mail
  #   from = Email.new(email: params[:from])
  #   to = Email.new(email: params[:to])
  #   subject = params[:booking_name]
  #   content = Content.new(type: 'text/plain', value: params[:description])
  #   mail = Mail.new(from, subject, to, content)
  #   sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  #   response = sg.client.mail._('send').post(request_body: mail.to_json)
  # end
end
