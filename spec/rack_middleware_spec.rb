# -*- encoding : utf-8 -*-
require 'rspec'
require 'rack'
require 'rack/test'
require 'rack/mock'
require 'digest/sha1'
require 'weibo_msg/middleware'

describe "WeiboMsg::Middleware" do

  include Rack::Test::Methods

  before(:all) do
    @app = lambda { |env| [200, { 'Content-Type' => 'text/plain' }, ['hello']] }
    @app_token = 'mytoken'
    @context_path = '/'
  end

  def middleware()
    WeiboMsg::Middleware.new @app, @app_token, @context_path
  end

  def mock_env(echostr, token = @app_token, path = '/')
    timestamp = Time.now.to_i.to_s
    nonce = '123456'
    param_array = [token, timestamp, nonce]
    sign = Digest::SHA1.hexdigest( param_array.sort.join )
    url = "#{path}?echostr=#{echostr}&timestamp=#{timestamp}&nonce=#{nonce}&signature=#{sign}"
    Rack::MockRequest.env_for(url)
  end

  it 'does not match the path info' do
    app = middleware
    echostr = '123'
    status, headers, body = app.call mock_env(echostr, @app_token, '/not_weibo_app')
    expect(status).to eq(200)
    expect(body).not_to eq([echostr])
  end

  it 'is valid weibo message request' do
    app = middleware
    echostr = '123'
    status, headers, body = app.call mock_env(echostr)
    expect(status).to eq(200)
    expect(body).to eq([echostr])
  end

  it 'is invalid weibo message request' do
    app = middleware
    status, headers, body = app.call mock_env('123', 'wrong_token')
    expect(status).to eq(401)
    expect(body).to eq([])
  end

end
