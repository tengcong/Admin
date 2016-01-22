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
end
