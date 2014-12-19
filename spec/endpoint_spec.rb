require 'endpoint'
require 'skimbot/skimism'
require 'rack/test'
ENV['RACK_ENV'] = 'test'

RSpec.describe 'skimbot endpoint' do
  include Rack::Test::Methods
  let(:app) {SkimEndpoint.new}
  before {post '/slack', {text: 'skim'}}

  def last_response_json
    JSON.parse(last_response.body)
  end

  it 'responds with 204 no content when skim is not mentioned' do
    post '/slack', {text: ''}
    expect(last_response.status).to eq 204
  end

  it 'shuts up' do
    post '/slack', {text: 'skim shut up'}
    expect(last_response_json['text']).to eq Skimism::SHUT_UP_RESPONSE
  end

  it 'responds 200 ok when skim is mentioned' do
    expect(last_response.status).to eq 200
  end

  it 'sends message as slack JSON response' do
    expect(last_response_json.keys).to include('text')
  end

  it 'sends a skimism as a response' do
    message = last_response_json['text']
    expect(Skimism::PHRASES).to include(message)
  end
end
