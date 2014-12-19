require 'sinatra'
require 'json'
require 'skimbot/bot'

class SkimEndpoint < Sinatra::Base

  @@allowed_to_speak = true

  post '/slack' do
    content_type :json 

    if text.match(/\bskim shut up\b/)
      shut_up!
    elsif text.match(/\bhey skim\b/)
      speak_again!
    elsif text.match(/\bskim\b/)
      bot_message
    else
      no_response
    end
  end

  def text
    params['text']
  end

  def shut_up!
    @@allowed_to_speak = false
    {text: Skimism::SHUT_UP_RESPONSE}.to_json
  end

  def speak_again!
    @@allowed_to_speak = true
    {text: Skimism::ALLOWED_TO_SPEAK_RESPONSE}.to_json
  end

  def bot_message
    if @@allowed_to_speak
      {text:  Bot.new.response}.to_json
    else
      no_response
    end
  end

  def no_response
    response.status = 204
  end
end
