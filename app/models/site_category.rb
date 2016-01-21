class SiteCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :site_types

  field :name
end
