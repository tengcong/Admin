class Album
  include Mongoid::Document
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps
  include Mongoid::Orderable

  include Mongoid::Publishable

  orderable

  field :title
  field :url
  field :thumbnail

  has_many :photos
end
