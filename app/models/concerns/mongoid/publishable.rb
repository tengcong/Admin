module Mongoid
  module Publishable
    extend ActiveSupport::Concern

    included do
      field :published, type: Boolean, default: false
      scope :published, -> { where(published: true) }
    end

    def publish!
      update published: true
    end

    def unpublish!
      update published: false
    end
  end
end
