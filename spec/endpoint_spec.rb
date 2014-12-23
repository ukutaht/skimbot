require 'endpoint'
require 'skimbot/skimism'
require 'rack/test'
ENV['RACK_ENV'] = 'test'

RSpec.describe 'skimbot endpoint' do
  include Rack::Test::Methods
  let(:app) {SkimEndpoint.new!}
  before {
    Bot.instance = Bot.new
    post '/slack', {text: 'skimbot'}}

  def last_response_json
    JSON.parse(last_response.body)
  end

  it 'responds with 204 no content when skim is not mentioned' do
    post '/slack', {text: ''}
    expect(last_response.status).to eq 204
  end

  it 'shuts up' do
    post '/slack', {text: 'skimbot shut up'}
    expect(last_response_json['text']).to eq Skimism::SHUT_UP_RESPONSE
    post '/slack', {text: 'skimbot'}
    expect(last_response.status).to eq 204
  end

  it 'comes back up' do
    post '/slack', {text: 'hey skimbot'}
    expect(last_response_json['text']).to eq Skimism::ALLOWED_TO_SPEAK_RESPONSE
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

  it 'interjects after 50 messages' do
    49.times {post '/slack', {text: 'something'}}
    message = last_response_json['text']
    expect(Skimism::PHRASES).to include(message)
  end

  it 'does not interject after 51 messages' do
    50.times {post '/slack', {text: 'something'}}
    expect(last_response.status).to eq 204
  end

  it 'interjects again after 100 messages' do
    99.times {post '/slack', {text: 'something'}}
    message = last_response_json['text']
    expect(Skimism::PHRASES).to include(message)
  end
end
