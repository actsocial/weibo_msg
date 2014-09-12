# -*- encoding : utf-8 -*-
require 'hashie'
require 'multi_json'

module WeiboMsg

  class ReplyMessage
    attr_accessor :type
    attr_accessor :result
    attr_accessor :receiver_id
    attr_accessor :sender_id
    attr_accessor :data
    attr_accessor :create_at

    def initialize
      @create_at = Time.now.to_i
      @data = Hashie::Mash.new({})
    end
  end

  class TextReplyMessage < ReplyMessage
    attr_accessor :text

    def initialize
      super
      @type = 'text'
    end
  end

  class PositionReplyMessage < ReplyMessage
    attr_accessor :longitude
    attr_accessor :latitude

    def initialize
      super
      @type = 'position'
    end
  end

  class Article
    attr_accessor :display_name
    attr_accessor :summary
    attr_accessor :image
    attr_accessor :url
  end

  class ArticlesReplyMessage < ReplyMessage
    attr_accessor :articles

    def initialize
      super
      @type = 'articles'
    end
  end

end
