class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Orderable

  orderable

  belongs_to :album

  field :url
  field :published, type: Boolean, default: true

  scope :published, -> { where(published: true) }

  def publish!
    update published: true
  end

  def unpublish!
    update published: false
  end
end
