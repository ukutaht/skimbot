require 'sinatra'
require 'json'
require 'skimbot/bot'

post '/slack' do
  content_type :json 
  {text:  Bot.new.response}.to_json
end
