class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Orderable
  include Publishable

  orderable

  belongs_to :album

  field :url

  mount_uploader :image, BeautyImageUploader

  def image_url
    url || image.url
  end
end
