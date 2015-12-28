class HomeController < ApplicationController

  before_action :auth, except: ['app']

  def index
  end

  def app
    render text: 'home'
  end
end
