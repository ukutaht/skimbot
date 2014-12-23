require 'skimbot/skimism'

class Bot
  class << self
    @@instance = Bot.new
    attr_accessor :instance
  end

  def initialize(can_speak=true, msg_counter=0)
    @can_speak = can_speak
    @msg_counter = msg_counter
  end

  def response(text)
    puts "MESSAGE_COUNT: #{@msg_counter}"
    puts "CAN SPEAK: #{@can_speak}"

    @msg_counter += 1
    if text.match(/\bskimbot shut up\b/)
      @can_speak = false
      Skimism::SHUT_UP_RESPONSE
    elsif text.match(/\bhey skimbot\b/)
      @can_speak = true
      Skimism::ALLOWED_TO_SPEAK_RESPONSE
    elsif text.match(/\bskimbot\b/)
      bot_message
    else
      interject_maybe
    end
  end

  def bot_message
    @can_speak && phrases.sample
  end

  def interject_maybe
    if @msg_counter > 49
      @msg_counter = 0
      bot_message
    end
  end

  def phrases
    @phrases ||=
      phrases_with_frequencies.flat_map do |skimism, frequency|
        (0...frequency).collect { skimism }
      end
  end

  private

  def phrases_with_frequencies
    Skimism::PHRASES_WITH_FREQUENCIES
  end
end
