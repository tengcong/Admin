class SiteType
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :sites, dependent: :destroy
  belongs_to :site_category

  field :name

  def self.mapping
    self.all.map{|type| [type.name, type.id] }
  end
end
