class HomeController < ApplicationController

  def index
  end

  def app
    render text: 'home'
  end
end
