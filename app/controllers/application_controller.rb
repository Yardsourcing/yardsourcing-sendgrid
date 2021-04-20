require 'sinatra'
require 'bundler'
require 'sendgrid-ruby'
require 'figaro/sinatra'
require 'sinatra/json'
require "sinatra/jsonp"
require "sinatra/namespace"
Bundler.require

class ApplicationController < Sinatra::Base
include SendGrid
register Sinatra::Namespace

  namespace '/api/v1' do
    before do
      content_type 'application/json'
    end

    post '/mail' do
      if valid_params?(params)
        send_email(params)
      else
        [400, ({message: "There was an error proccessing your request"}).to_json]
      end
    end
  end

  def send_email(params)
    from = Email.new(email: params[:from])
    to = Email.new(email: params[:to])
    subject = params[:subject]
    content = Content.new(type: 'text/plain', value: params[:content])
    mail = Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    if response.status_code == "202"
      [202, ({message: "Message sent successfully"}).to_json]
    else
      [400, ({message: "There was an error proccessing your request"}).to_json]
    end
  end

  def valid_params?(params)
    return false unless it_exists?(params[:from])
    return false unless (params[:from] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i) == 0
    return false unless it_exists?(params[:to])
    return false unless (params[:to] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i) == 0
    return false unless it_exists?(params[:subject])
    return false unless it_exists?(params[:content])
    true
  end

  def it_exists?(message)
    return false unless message
    return false unless message != ""
    true
  end
end
