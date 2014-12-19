require 'sinatra'
require 'json'
require 'skimbot/bot'

allowed_to_speak = true

class SkimEndpoint < Sinatra::Base

  def initialize(app=nil, allowed_to_speak=true)
    super(app)
    @allowed_to_speak = allowed_to_speak
  end

  post '/slack' do
    content_type :json 
    case
    when text.match(/skim shut up/)
      shut_up!
    when text.match(/hey skim/)
      speak_again!
    when text.match(/\bskim\b/)
      bot_message
    else
      no_response
    end
  end

  def text
    params['text']
  end

  def shut_up!
    @allowed_to_speak = false
    {text: Skimism::SHUT_UP_RESPONSE}.to_json
  end

  def speak_again!
    @allowed_to_speak = true
    {text: Skimism::ALLOWED_TO_SPEAK_RESPONSE}.to_json
  end

  def bot_message
    if @allowed_to_speak
      {text:  Bot.new.response}.to_json
    else
      no_response
    end
  end

  def no_response
    response.status = 204
  end
end
