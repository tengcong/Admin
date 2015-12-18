class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def model
    self.class.to_s.gsub('Controller', '').singularize.constantize
  end
end
