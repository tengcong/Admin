class Album
  include Mongoid::Document
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps
  include Mongoid::Orderable

  orderable

  field :title
  field :url
  field :thumbnail
  field :published, type: Boolean, default: false

  has_many :photos

  scope :published, -> { where(published: true) }

  def publish!
    update published: true
  end

  def unpublish!
    update published: false
  end
end
