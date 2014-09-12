# -*- encoding : utf-8 -*-
require 'multi_json'
require 'nestful'

module WeiboMsg

  class MessageCustom < Api

    def gw_path
      "/messages/reply.json?access_token=#{access_token}"
    end

    def send(message)
      response = Nestful.post "#{gw_path}", MultiJson.dump(message) rescue nil
      check_response(response)
    end

  end

end
