require 'mongoid'

class Log
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content

  belongs_to :user
end
