require 'sinatra'
require 'mongoid'
require 'open-uri'

Mongoid.load!("config/mongoid.yml", 'development')

Dir["./models/*.rb"].each { |f| require f }

class App < Sinatra::Base

  set :bind, '0.0.0.0'

  post '/create_user' do
    response['Access-Control-Allow-Origin'] = '*'
    if User.find_or_create_by(email: params[:email])
      { success: true }.to_json
    else
      { success: false }.to_json
    end
  end

  post '/down' do
    response['Access-Control-Allow-Origin'] = '*'
    photo = Photo.find params[:id]
    res = photo.inc(download_count: 1)
    { code: 0, message: 'success', data: photo }.to_json
  end

  get '/total_count' do
    { code: 0, message: 'success', data: Photo.count }.to_json
  end

  get '/list' do
    limit = params[:limit] ? params[:limit].to_i : 100
    offset = params[:offset] ? params[:offset].to_i : 0

    @photos = Photo.offset(offset).limit(limit)
    { code: 0, message: 'success', data: @photos }.to_json
  end

  get '/' do
    limit = params[:limit] ? params[:limit].to_i : 21
    @photos = Photo.random(limit)
    erb :index
  end

  get '/check_submit' do
    @users = User.all
    erb :check_submit
  end

  get '/user/:id' do
    @photos = User.find(params[:id]).photos.desc('created_at')
    erb :delete
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
    { code: 0, message: 'success', data: res }.to_json

  end

  get '/submit' do
    erb :submit
  end

  post '/report/:id' do
    photo = Photo.find params[:id]
    res = photo.get_reported
    { code: 0, message: 'success', data: res }.to_json
  end

  get '/report_list' do
    offset = params[:offset] || 0
    limit = params[:limit] || 100
    @photos = Photo.reported.desc('created_at').offset(offset).limit(limit)
    erb :delete
  end

  post '/submit' do
    response['Access-Control-Allow-Origin'] = '*'
    begin
      user = User.find_by email: params[:email]
    rescue
      return {success: false, message: 'login first'}.to_json
    end

    origin_url = params[:url]

    puts '=' * 30
    puts user.email
    puts origin_url

    uploader = Uploader.instance
    if user && !Photo.where(origin_url: origin_url).exists? && url = uploader.upload_with(origin_url)
      res = user.photos.create(origin_url: origin_url, url: url, type: 1, download_count: (1..100).to_a.sample)
      {success: res}.to_json
    end
  end
end
