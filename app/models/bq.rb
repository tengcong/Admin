class Bq
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :bq_package

  field :origin_url, type: String

  mount_uploader :image, BqImageUploader

  def image_url
    origin_url || image.url
  end
end
