require 'sinatra'
require 'mongoid'
require 'open-uri'

Mongoid.load!("config/mongoid.yml", 'development')

Dir["./models/*.rb"].each { |f| require f }

class App < Sinatra::Base

  set :bind, '0.0.0.0'

  get '/list' do
    offset = params[:offset] || 0
    limit = params[:limit] || 10
    @photos = Photo.desc('created_at').offset(offset).limit(limit)
    {data: @photos}.to_json
  end

  get '/' do
    offset = params[:offset] || 0
    limit = params[:limit] || 21
    @photos = Photo.desc('created_at').offset(offset).limit(limit)
    erb :index
  end

  get '/delete' do
    offset = params[:offset] || 0
    limit = params[:limit] || 100
    @photos = Photo.desc('created_at').offset(offset).limit(limit)
    erb :delete
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
    response['Access-Control-Allow-Origin'] = '*'
    origin_url = params[:url]
    puts '=' * 30
    puts origin_url
    uploader = Uploader.instance
    if !Photo.where(origin_url: origin_url).exists? && url = uploader.upload_with(origin_url)
      res = Photo.create(origin_url: origin_url, url: url, type: 1)
    end
    {success: res}.to_json
  end
end
