class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  if not Rails.env.development?
    http_basic_authenticate_with name: "tengcong", password: "123456"
  end

  def model
    self.class.to_s.gsub('Controller', '').singularize.constantize
  end
end
