require 'mongoid'

class Photo
  include Mongoid::Document

  field :origin_url, type: String
  field :url,        type: String

  # [0, 1] 0 users, 1 robot
  field :type,       type: Integer

end
