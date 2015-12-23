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

  scope :ordered, -> { order(position: :asc) }

  accepts_nested_attributes_for :bqs

  def self.search(q)
    self.any_of({ name: /.*#{q}.*/ })
  end

  def add_image image_file
    self.bqs.create(image: image_file)
  end
end
