module Publishable
  extend ActiveSupport::Concern

  def published
    @collection = model.published.ordered.page params[:page]
  end

  def publish
    model.find(params[param_key]).publish!
    render js: 'window.location.reload()'
  end

  def unpublish
    model.find(params[param_key]).unpublish!
    render js: 'window.location.reload()'
  end

  def param_key
    "#{model.to_s.underscore}_id".to_sym
  end
end
