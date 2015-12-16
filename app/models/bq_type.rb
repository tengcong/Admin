class BqType
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :bq_packages

  field :name, type: String
  field :url,  type: String
end

