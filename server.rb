require 'sinatra'
require 'mongoid'

set :bind, '0.0.0.0'

Mongoid.load!("config/mongoid.yml", 'development')

Dir["./models/*.rb"].each { |f| require f }

get '/' do
  offset = params[:offset]
  limit = params[:limit]
  @photos = Photo.offset(offset).limit(limit)
  erb :index
end

get '/delete/:id' do
  photo = Photo.find params[:id]
  photo.destroy
  true
end
