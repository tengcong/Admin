require 'sinatra'
require 'mongoid'

Mongoid.load!("config/mongoid.yml", 'development')

Dir["./models/*.rb"].each { |f| require f }

get '/' do
  @photos = Photo.all
  erb :index
end
