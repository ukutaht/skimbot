require 'endpoint'
require 'skimbot/skimism'
require 'rack/test'
ENV['RACK_ENV'] = 'test'

RSpec.describe 'skimbot endpoint' do
  include Rack::Test::Methods
  let(:app) {Sinatra::Application}
  before {post '/slack', {}.to_json}

  def last_response_json
    JSON.parse(last_response.body)
  end

  it 'responds to slack request' do
    expect(last_response).to be_ok
  end

  it 'sends message as slack JSON response' do
    expect(last_response_json.keys).to include('text')
  end

  it 'sends a skimism as a response' do
    message = last_response_json['text']
    expect(Skimism::PHRASES).to include(message)
  end
end
