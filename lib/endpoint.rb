require 'sinatra'
require 'json'
require 'skimbot/bot'

post '/slack' do
  content_type :json 
  if skim_mentioned?
    {text:  Bot.new.response}.to_json
  else
    response.status = 204
  end
end

def skim_mentioned?
  request_text.match /\bskim\b/
end

def request_text
  JSON.parse(request.body.read)["text"]
end
