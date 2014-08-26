require 'sinatra'
require 'mongoid'

set :bind, '0.0.0.0'

Mongoid.load!("config/mongoid.yml", 'development')

Dir["./models/*.rb"].each { |f| require f }

get '/' do
  offset = params[:offset] || 0
  limit = params[:limit] || 100
  @photos = Photo.offset(offset).limit(limit)
  erb :index
end

get '/delete/:id' do
  photo = Photo.find params[:id]
  res = photo.destroy
  {success: res}.to_json
end
