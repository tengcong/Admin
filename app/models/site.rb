class Site
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Orderable

  orderable
  scope :ordered, -> { order(position: :asc) }

  has_many :crawling_endpoints, dependent: :destroy
  belongs_to :site_type

  field :title
  field :url
  field :icon_url
  field :crawlable, type: Boolean, default: false

end
