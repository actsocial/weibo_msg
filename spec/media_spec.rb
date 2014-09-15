# -*- encoding : utf-8 -*-
require 'rspec'
require 'weibo_msg/api'
require 'weibo_msg/media'
require 'weibo_msg/uploader'

describe "WeiboMsg::Media" do

  let(:media_client) do
    media_client = WeiboMsg::Media.new(
      nil,
      nil,
      '2.00BlpzhFeXuwhDa23cac41b5TF_OtC',
      nil,
      "https://api.weixin.qq.com/cgi-bin"
    )
  end

  let(:image_jpg_path) do
    "#{File.dirname(__FILE__)}/media/ruby.jpg"
  end

  let(:image_jpg_file) do
    File.new(image_jpg_path)
  end

  let(:remote_png_path) do
    "https://www.ruby-lang.org/images/header-ruby-logo@2x.png"
  end

  let(:remote_jpg_path) do
    "http://a.hiphotos.baidu.com/image/pic/item/024f78f0f736afc3419cb4aab119ebc4b6451268.jpg"
  end

  it "can upload a jpg File image" do
    response = media_client.upload_media(image_jpg_file, "image")
    expect(response.code).to eq()
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "can upload a local image" do
    response = media_client.upload_media(image_jpg_path, "image")
    expect(response.code).to eq()
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "can upload a remote png image" do
    response = media_client.upload_media(remote_png_path, "image")
    expect(response.code).to eq()
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "can upload a remote jpg image" do
    response = media_client.upload_media(remote_jpg_path, "image")
    expect(response.code).to eq()
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "#download_media_url return a String url" do
    image = media_client.upload_media(image_ico_path, "image")
    media_id = image.result["media_id"]
    image_url = media_client.download_media_url(media_id)
    expect(image_url.class).to eq(String)
  end

end
