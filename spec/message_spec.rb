# -*- encoding : utf-8 -*-
require 'rspec'
require 'weibo_msg/message'

describe 'weibo_msg/message' do

  context 'WeiboMsg::Message' do
    it 'is a text message' do
      msg = WeiboMsg::Message.factory(%(
      {
        "type": "text",
        "receiver_id": 1902538057,
        "sender_id": 2489518277,
        "created_at": "Mon Jul 16 18:09:20 +0800 2012",
        "text": "私信或留言内容",
        "data": {}
      }
      ))
      expect(msg.class).to eq(WeiboMsg::TextMessage)
      expect(msg.type).to eq('text')
      expect(msg.receiver_id).to eq(1902538057)
      expect(msg.sender_id).to eq(2489518277)
      expect(msg.created_at).to eq('Mon Jul 16 18:09:20 +0800 2012')
      expect(msg.text).to eq('私信或留言内容')
    end

    it 'is a position message' do
      msg = WeiboMsg::Message.factory(%(
      {
        "type": "position",
        "receiver_id": 1902538057,
        "sender_id": 2489518277,
        "created_at": "Mon Jul 16 18:09:20 +0800 2012",
        "text": "我在这里: http://t.cn/zQgLLYO",
        "data": {
          "longitude": "116.308586",
          "latitude": "39.982525"
        }
      }
      ))
      expect(msg.class).to eq(WeiboMsg::PositionMessage)
      expect(msg.type).to eq('position')
      expect(msg.receiver_id).to eq(1902538057)
      expect(msg.sender_id).to eq(2489518277)
      expect(msg.created_at).to eq('Mon Jul 16 18:09:20 +0800 2012')
      expect(msg.text).to eq('我在这里: http://t.cn/zQgLLYO')
      expect(msg.data.longitude).to eq('116.308586')
      expect(msg.data.latitude).to eq('39.982525')
    end

    it 'is a image message' do
      msg = WeiboMsg::Message.factory(%(
      {
        "type": "image",
        "receiver_id": 1902538057,
        "sender_id": 2489518277,
        "created_at": "Mon Jul 16 18:09:20 +0800 2012",
        "text": "发了一张图片",
        "data": {
          "vfid": 821804459,     // 发送者用此ID查看图片
          "tovfid": 821804469    // 接收者用此ID查看图片
        }
      }
      ))
      expect(msg.class).to eq(WeiboMsg::ImageMessage)
      expect(msg.type).to eq('image')
      expect(msg.receiver_id).to eq(1902538057)
      expect(msg.sender_id).to eq(2489518277)
      expect(msg.created_at).to eq('Mon Jul 16 18:09:20 +0800 2012')
      expect(msg.text).to eq('发了一张图片')
      expect(msg.data.vfid).to eq(821804459)
      expect(msg.data.tovfid).to eq(821804469)
    end

  end

end
