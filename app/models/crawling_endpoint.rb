class CrawlingEndpoint
  include Mongoid::Document
  include Mongoid::Timestamps

  field :url

  belongs_to :site
end
