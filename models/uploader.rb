require 'upyun-sdk'

class Uploader
  def initialize
    @up_client = UpYun.new("lol-image", "lifedim", "Mixswift14", 2)
  end

  def self.instance
    @uploader ||= self.new
  end

  def delete url
    file_name = url.match(/com(.+)/)[1]
    @up_client.delete(file_name)
  end

  def upload_with url
    file_name = "/#{Time.now.to_i}"
    if @up_client.put(file_name, open(url).read)
      puts "http://lol-image.b0.upaiyun.com#{file_name}"
      "http://lol-image.b0.upaiyun.com#{file_name}"
    else
      false
    end
  end
end
