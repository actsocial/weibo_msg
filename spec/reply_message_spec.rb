# -*- encoding : utf-8 -*-
require 'rspec'
require 'weibo_msg/reply_message'

describe 'weibo_msg/reply_message' do

  context 'WeiboMsg::ReplyMessage' do
    it 'is a text reply message' do
      msg = WeiboMsg::TextReplyMessage.new
      msg.result = true
      msg.receiver_id = '123456'
      msg.sender_id = '123123'
      msg.data.text = '纯文本回复'
      pp msg
      expect(msg.type).to  eq('text')
    end

    it 'is a position reply message' do
      msg = WeiboMsg::PositionReplyMessage.new
      msg.result = true
      msg.receiver_id = '123456'
      msg.sender_id = '123123'
      msg.data.longitude = '116.308586'
      msg.data.latitude = '39.982525'
      pp msg
      expect(msg.type).to eq('position')
    end

    it 'is a articles reply message' do
      msg = WeiboMsg::ArticlesReplyMessage.new
      msg.result = true
      msg.receiver_id = '123456'
      msg.sender_id = '123123'
      article1 = WeiboMsg::Article.new
      article1.display_name = '两个故事'
      article1.summary = '今天讲两个故事，分享给你。谁是公司？谁又是中国人'
      article1.image = 'http://storage.mcp.weibo.cn/0JlIv.jpg'
      article1.url = 'http://e.weibo.com/mediaprofile/article/detail?uid=1722052204&aid=983319'
      article2 = WeiboMsg::Article.new
      article2.display_name = '11111'
      article2.summary = '今天讲两个故事，分享给你。'
      article2.image = 'http://storage.mcp.weibo.cn/0Jv.jpg'
      article2.url = 'http://e.weibo.com/mediaprofile/article/detail?uid=1722052204&aid=1111'
      msg.data.articles = [article1, article2]
      expect(msg.type).to eq('articles')
    end
  end

end
