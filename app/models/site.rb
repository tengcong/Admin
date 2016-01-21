class Site
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Orderable

  orderable
  scope :ordered, -> { order(position: :asc) }

  field :title
  field :url
  field :icon_url
  belongs_to :site_type
end
