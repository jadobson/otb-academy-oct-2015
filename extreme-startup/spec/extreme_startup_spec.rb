ENV['RACK_ENV'] = 'test'

require_relative '../extreme_startup'
require 'rspec'
require 'rack/test'

describe "extreme_startup" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "returns an answer" do
    get "/?q=123:hello"
    expect(last_response).to be_ok
  end
end
