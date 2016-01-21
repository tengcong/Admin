class HomeController < ApplicationController
  def index
    @site_categories = SiteCategory.all
  end
end
