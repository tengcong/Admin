class BqType
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :bqs

  field :name, type: String
  field :url,  type: String
end

