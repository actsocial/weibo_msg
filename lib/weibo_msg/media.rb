# -*- encoding : utf-8 -*-
require 'multi_json'
require 'rest-client'

module WeiboMsg

  class Media < Api

    def gw_path
      "http://upload.api.weibo.com/2/mss"
    end

    def upload_media(media, media_type)
      file = process_file(media)
      url = "#{gw_path}/media_upload.json?type=#{media_type}&access_token=#{access_token}"
      payload = {:media => file}
      response = RestClient::Request.execute(:method => :post, :url => url, :payload => payload)
      check_response(response)
    end

    def download_media_url(media_id)
      download_media_url = "#{gw_path}/media_msget.json"
      params = URI.encode_www_form("access_token" => access_token,
                                   "media_id"     => media_id)

      download_media_url += "?#{params}"
      download_media_url
    end

    private

      def process_file(media)
        return media if media.is_a?(File) && jpep?(media)

        media_url = media
        uploader  = WeiboMsgUploader.new

        if http?(media_url) # remote
          uploader.download!(media_url.to_s)
        else # local
          media_file = media.is_a?(File) ? media : File.new(media_url)
          uploader.cache!(media_file)
        end
        # file = process_media(uploader)
        file = File.new uploader.file.file
        CarrierWave.clean_cached_files! # clear last one day cache
        file
      end

      def process_media(uploader)
        uploader = covert(uploader)
        uploader.file.to_file
      end

      def covert(uploader)
        # image process
        unless (uploader.file.content_type =~ /image/).nil?
          if !jpep?(uploader.file)
            require "mini_magick"
            # covert to jpeg
            image = MiniMagick::Image.open(uploader.file)
            image.format("jpg")
            uploader.cache!(File.open(image.path))
            image.destroy!
          end
        end
        uploader
      end

      def http?(uri)
        return false if !uri.is_a?(String)
        uri = URI.parse(uri)
        uri.scheme =~ /^https?$/
      end

      def jpep?(file)
        content_type = if file.respond_to?(:content_type)
          file.content_type
        else
          content_type(file.path)
        end
        !(content_type =~ /jpeg/).nil?
      end

      def content_type(media_path)
        MIME::Types.type_for(media_path).first.content_type
      end

  end
end
