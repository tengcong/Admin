class BqPackage
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :bq_type
  has_many :bqs

  field :name
  field :url

  field :published, type: Boolean, default: false

  scope :desc, -> { order(created_at: :desc) }
end
