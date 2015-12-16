require 'mongoid'

class BqType
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :bq_packages

  field :name, type: String
  field :url,  type: String
end

class Bq
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :bq_package
  field :origin_url, type: String
end

class BqPackage
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :bq_type
  has_many :bqs

  field :name
  field :url
end
