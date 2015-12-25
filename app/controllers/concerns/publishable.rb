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

  def batch_publish
    model.any_in(id: params[:ids]).each do |resource|
      resource.publish!
    end

    render json: { success: true }
  end

  def batch_unpublish
    model.any_in(id: params[:ids]).each do |resource|
      resource.unpublish!
    end

    render json: { success: true }
  end

  def param_key
    "#{model.to_s.underscore}_id".to_sym
  end
end
