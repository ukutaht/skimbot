require 'skimbot/bot'
require 'skimbot/skimism'

RSpec.describe Bot do
  let(:skim) { Bot.new } 
  let(:phrases_with_frequencies) { Skimism::PHRASES_WITH_FREQUENCIES }

  it 'responds with a skimism' do
    expect(skim.phrases).to include(skim.response)
  end

  it 'multiplies each phrase by the frequency' do
    phrases_with_frequencies.each do |phrase, freq| 
      filtered = skim.phrases.select {|p| p == phrase}
      expect(filtered.size).to equal(freq)
    end
  end
end
