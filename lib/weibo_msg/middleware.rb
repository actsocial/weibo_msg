# -*- encoding : utf-8 -*-
require 'digest/sha1'

module WeiboMsg

  class Middleware

    POST_BODY      = 'rack.input'.freeze
    WEIBO_MSG      = 'weibo.msg'.freeze
    WEIBO_MSG_RAW  = 'weibo.msg.raw'.freeze

    def initialize(app, app_token, path)
      @app = app
      @app_token = app_token
      @path = path
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      if @path == env['PATH_INFO'].to_s && ['GET', 'POST'].include?(env['REQUEST_METHOD'])
        @req = Rack::Request.new(env)
        return invalid_request! unless request_is_valid?
        return [
          200,
          { 'Content-type' => 'text/plain', 'Content-length' => @req.params['echostr'].length.to_s },
          [ @req.params['echostr'] ]
        ] if @req.get?

        raw_msg = env[POST_BODY].read
        begin
          env.update WEIBO_MSG => WeiboMsg::Message.factory(raw_msg), WEIBO_MSG_RAW => raw_msg
          @app.call(env)
        rescue Exception => e
          return [500, { 'Content-type' => 'text/html' }, ["Message parsing error: #{e.to_s}"]]
        end
      else
        @app.call(env)
      end

    end

    def invalid_request!
      self.class.invalid_request!
    end

    def self.invalid_request!
      [401, { 'Content-type' => 'text/html', 'Content-Length' => '0'}, []]
    end

    def request_is_valid?
      self.class.request_is_valid?(@app_token, @req.params)
    end

    def self.request_is_valid?(app_token, params)
      begin
        param_array = [app_token, params['timestamp'], params['nonce']]
        sign = Digest::SHA1.hexdigest( param_array.sort.join )
        sign == params['signature'] ? true : false
      rescue
        false
      end
    end
  end

end
