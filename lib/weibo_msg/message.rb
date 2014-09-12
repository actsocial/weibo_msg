# -*- encoding : utf-8 -*-
require 'hashie'
require 'multi_json'

module WeiboMsg

  class Message

    def initialize(hash)
      @source = Hashie::Mash.new(hash)
    end

    def method_missing(method, *args, &block)
      @source.send(method, *args, &block)
    end

    def created_at
      @source.created_at
    end

    def self.factory(json)
      hash = MultiJson.load(json)

      case hash['type']
      when 'text'
        TextMessage.new(hash)
      when 'image'
        ImageMessage.new(hash)
      when 'position'
        PositionMessage.new(hash)
      when 'event'
        EventMessage.new(hash)
      when 'video'
        VideoMessage.new(hash)
      else
        raise ArgumentError, 'Unknown Message'
      end
    end

  end


  TextMessage = Class.new(Message)

  EventMessage = Class.new(Message)

  VoiceMessage = Class.new(Message)

  ImageMessage = Class.new(Message)

  PositionMessage = Class.new(Message)

end
