class SiteCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :site_types, dependent: :destroy

  field :name

  def self.mapping
    self.pluck(:name, :id)
  end
end
