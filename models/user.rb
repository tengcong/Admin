require 'mongoid'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String

  field :uniq_token, type: String

  has_many :photos

  has_many :logs, dependent: :destroy

  def like photo
    if photo
      photo.inc(like_count: 1)
      logs.create content: "like photo -- #{photo.id}"
    end
  end

  def report photo
    if photo
      photo.get_reported
      logs.create content: "report photo -- #{photo.id}"
    end
  end

end
