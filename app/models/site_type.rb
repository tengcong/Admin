class SiteType
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :sites, dependent: :destroy
  belongs_to :site_category

  field :name
end
