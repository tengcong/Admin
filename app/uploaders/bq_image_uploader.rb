# encoding: utf-8

class BqImageUploader < CarrierWave::Uploader::Base

  storage :upyun
  self.upyun_bucket = "bqqqq"
  self.upyun_bucket_host = "http://bqqqq.b0.upaiyun.com"

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
