class SiteType
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :sites
  belongs_to :site_category

  field :name
end
