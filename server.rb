require 'sinatra'
require 'mongoid'
require 'open-uri'

set :bind, '0.0.0.0'

Mongoid.load!("config/mongoid.yml", 'development')

Dir["./models/*.rb"].each { |f| require f }

get '/' do
  offset = params[:offset] || 0
  limit = params[:limit] || 100
  @photos = Photo.desc('created_at').offset(offset).limit(limit)
  erb :index
end

get '/delete/:id' do
  photo = Photo.find params[:id]
  res = photo.destroy
  {success: res}.to_json
end

get '/submit' do
  erb :submit
end

post '/submit' do
  cross_origin
  origin_url = params[:url]
  puts '=' * 30
  puts origin_url
  uploader = Uploader.instance
  if !Photo.where(origin_url: origin_url).exists? && url = uploader.upload_with(origin_url)
    res = Photo.create(origin_url: origin_url, url: url, type: 1)
  end
  {success: res}.to_json
end
