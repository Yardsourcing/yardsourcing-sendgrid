require 'sinatra'

post '/mail' do
  email = Mailer.contact
  email.deliver
end
