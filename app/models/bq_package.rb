class BqPackage
  include Mongoid::Document
  include Mongoid::Document::Taggable
  include Mongoid::Timestamps
  include Mongoid::Orderable

  orderable

  belongs_to :bq_type
  has_many :bqs

  field :name
  field :url

  field :published, type: Boolean, default: false

  scope :desc, -> { order(updated_at: :desc) }
  scope :published, -> { where(published: true) }

  def publish!
    update published: true
  end

  def unpublish!
    update published: false
  end
end
