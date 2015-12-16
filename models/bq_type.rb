require 'mongoid'

class BqType
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :bqs

  field :name, type: String
  field :url,  type: String
end

class Bq
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :bq_type
  field :origin_url, type: String
end
