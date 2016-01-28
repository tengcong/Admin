class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Orderable
  include Publishable

  orderable

  field :title
  field :thumbnail
  field :description
  field :body
  field :detail_page_url
  field :published_at, type: DateTime

end
