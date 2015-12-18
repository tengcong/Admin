class BqPackage
  include Mongoid::Document
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps
  include Mongoid::Orderable

  include Mongoid::Publishable

  orderable

  belongs_to :bq_type
  has_many :bqs

  field :name
  field :url

  scope :desc, -> { order(updated_at: :desc) }
end
