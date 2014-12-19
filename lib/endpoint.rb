require 'sinatra'
require 'json'
require 'skimbot/bot'

post '/slack' do
  content_type :json 
  slack_response = {:text => Bot.new.response,
                    :token => params["token"]}
  slack_response.to_json
end
