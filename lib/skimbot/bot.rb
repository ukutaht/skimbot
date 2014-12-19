require 'skimbot/skimism'

class Bot
  def response
    phrases.sample
  end

  def phrases
    phrases_with_frequencies.flat_map do |skimism, frequency|
      (0...frequency).collect { skimism }
    end
  end

  private

  def phrases_with_frequencies
    Skimism::PHRASES_WITH_FREQUENCIES
  end
end
