# -*- encoding : utf-8 -*-
require 'multi_json'
require 'nestful'

module WeiboMsg

  class Client

    attr_accessor :app_key, :app_secret, :access_token, :expired_at, :endpoint

    def initialize(app_key, app_secret, access_token = nil, expired_at = nil)
      @app_key      = app_key
      @app_secret   = app_secret
      @access_token = access_token
      @expired_at   = (expired_at || Time.now)
      @endpoint     = 'https://api.weibo.com'
    end

    def get_access_token
      if expired?
        authenticate
      end
      @access_token
    end

    def expired?
      Time.now >= @expired_at
    end

    def expired_at
      @expired_at
    end

    def self.authenticate(endpoint, app_key, app_secret)
      # wait for development of weibo

      # url = "#{endpoint}/token"
      # request = Nestful.get url, { :grant_type => 'client_credential', :appid => api, :secret => key } rescue nil
      # unless request.nil?
      #   auth = MultiJson.load(request.body)
      #   unless auth.has_key?('errcode')
      #     access_token = auth['access_token']
      #     expired_at   = Time.now + auth['expires_in'].to_i
      #   end

      # end

      # return access_token, expired_at
    end

    def authenticate
      @access_token, @expired_at = self.class.authenticate(@endpoint, @app_key, @app_secret)
    end

    def user
      User.new(@app_key, @app_secret, get_access_token, @expired_at, @endpoint)
    end

    # def menu
    #   Menu.new(@api, @key)
    # end

    def message_custom
      MessageCustom.new(@app_key, @app_secret, get_access_token, @expired_at, @endpoint)
    end
  end
end
