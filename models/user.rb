require 'mongoid'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  has_many :photos

end
