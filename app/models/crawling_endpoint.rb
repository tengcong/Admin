class CrawlingEndpoint
  include Mongoid::Document
  include Mongoid::Timestamps

  field :url
  field :list_selector
  field :detail_selector
end
