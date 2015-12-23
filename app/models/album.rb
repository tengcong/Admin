class Album
  include Mongoid::Document
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps
  include Mongoid::Orderable
  include Mongoid::Publishable

  orderable
  is_impressionable

  field :title
  field :url
  field :thumbnail

  has_many :photos

  scope :ordered, -> { order(position: :asc) }

  def self.search(q)
    self.any_of({ title: /.*#{q}.*/ })
  end

  def add_image image_file
    self.photos.create(image: image_file)
  end
end
