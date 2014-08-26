require 'upyun-sdk'

class Uploader
  def initialize
    @up_client = UpYun.new("swiftist-images", "lifedim", "Mixswift14", 2)
  end

  def upload_with url
    file_name = "/imgs/#{Time.now.to_i}"
    if @up_client.put(file_name, open(url).read)
      puts "http://swiftist-images.b0.upaiyun.com#{file_name}"
      "http://swiftist-images.b0.upaiyun.com#{file_name}"
    else
      false
    end
  end
end
