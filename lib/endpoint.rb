require 'sinatra'
require 'json'
require 'skimbot/bot'

post '/slack' do
  content_type :json 
  token = json(request.body.read)["token"]
  slack_response = {text:  Bot.new.response,
                    token: token}
  slack_response.to_json
end

def json(string)
  JSON.parse(string)
end
