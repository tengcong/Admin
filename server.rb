require 'sinatra'
require 'mongoid'

set :bind, '0.0.0.0'

Mongoid.load!("config/mongoid.yml", 'development')

Dir["./models/*.rb"].each { |f| require f }

get '/' do
  @photos = Photo.desc('created_at').limit(100)
  erb :index
end
