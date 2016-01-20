class Admin::MainController < ActionController::Base
  protect_from_forgery with: :exception

  layout "admin"

  before_filter do
    unless Rails.env.development? || request.format == 'application/json'
      authenticate_or_request_with_http_basic("ADMIN PANEL") do |name, password|
        name == 'tengcong' && password == '123456'
      end
    end
  end

  def model
    self.class.to_s.gsub('Admin::', '').gsub('Controller', '').singularize.constantize
  end
end
