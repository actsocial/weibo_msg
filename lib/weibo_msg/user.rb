# -*- encoding : utf-8 -*-
require 'multi_json'
require 'nestful'

module WeiboMsg

  class User < Api

    def gw_path(method)
      "/eps/user/#{method}.json?access_token=#{access_token}"
    end

    def info(uid, lang = nil)
      url = "#{gw_url('info')}&uid=#{uid}"
      url = "#{url}&lang=#{lang}" if lang.present?

      request = Nestful.get url rescue nil
      MultiJson.load(request.body) unless request.nil?
    end

  end

end
