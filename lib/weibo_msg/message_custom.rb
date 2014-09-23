# -*- encoding : utf-8 -*-
require 'multi_json'
require 'rest-client'
require 'cgi'

module WeiboMsg

  class MessageCustom < Api

    def gw_path
      "https://m.api.weibo.com/2/messages/reply.json?access_token=#{access_token}"
    end

    def send(message)
      query_string = message.collect { |k, v| "#{k.to_s}=#{CGI::escape(v.to_s)}" }.join('&')
      url = "#{gw_path}&#{query_string}"
      response = RestClient::Request.execute(:method => :post, :url => url)
      check_response(response)
    end

  end

end
