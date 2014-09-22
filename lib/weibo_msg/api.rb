# -*- encoding : utf-8 -*-
require 'multi_json'
require 'nestful'

module WeiboMsg

  class Api

    attr_accessor :api, :key, :access_token, :expired_at, :endpoint

    def initialize(api, key, access_token = nil, expired_at = nil, endpoint = nil)
      self.api = api
      self.key = key
      self.access_token = access_token
      self.expired_at   = expired_at
      self.endpoint     = endpoint
    end

    def gw_path(method)
    end

    def gw_url(method)
      "#{endpoint}" + gw_path(method)
    end

    def check_response(response)
      unless response.nil?
        error_code = MultiJson.load(response.body)['error_code']
        return MultiJson.load(response.body) if error_code.nil?
      end
      false
    end

  end

end
