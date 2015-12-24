# encoding: utf-8

class BeautyImageUploader < CarrierWave::Uploader::Base

  storage :upyun
  self.upyun_bucket = "beautyy"
  self.upyun_bucket_host = "http://beautyy.b0.upaiyun.com"

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
