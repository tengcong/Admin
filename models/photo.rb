require 'mongoid'

class Photo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :origin_url, type: String
  field :url,        type: String

  # [0, 1] 0 users, 1 robot
  field :type,       type: Integer

  belongs_to :user

  before_destroy :destroy_from_upyun

  def self.random n
    count = self.count
    offset = Random.rand(count) + 1
    offset = count - n if offset + n > count
    self.skip(offset).limit(n).shuffle
  end

  def destroy_from_upyun
    puts '-' * 30
    puts 'delete from upyun'
    puts Uploader.instance.delete url
  end

end
