class Bq
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :bq_type
  field :origin_url, type: String
end
