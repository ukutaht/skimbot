require 'sinatra'
require 'json'
require 'skimbot/bot'

class SkimEndpoint < Sinatra::Application

  post '/slack' do
    content_type :json 

    if res = bot.response(text)
      {text: res}.to_json
    else
      no_response
    end
  end

  def bot
    Bot.instance
  end

  def text
    params['text']
  end

  def no_response
    response.status = 204
  end
end
