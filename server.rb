require 'sinatra'
require 'mongoid'
require 'open-uri'

Mongoid.load!("config/mongoid.yml", 'development')

Dir["./models/*.rb"].each { |f| require f }

class App < Sinatra::Base

  set :bind, '0.0.0.0'

  ########### these are for chrome plugin ###########

  post '/create_user' do
    response['Access-Control-Allow-Origin'] = '*'
    if User.find_or_create_by(email: params[:email])
      { success: true }.to_json
    else
      { success: false }.to_json
    end
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
      res = user.photos.create(origin_url: origin_url, url: url, type: 1, like_count: (1..100).to_a.sample)
      {success: res}.to_json
    end
  end

  ########### these are for chrome plugin ###########

  ########### these are APIs for mobile client ###########


  get '/pengpeng' do
    current_user = User.find_or_create_by(uniq_token: params[:uniq_token]) if params[:uniq_token]

    result = Pengpeng.get_result

    if current_user
      current_user.logs.create content: "pengpeng: #{result}"
    end

    { code: 0, message: 'success', data: result }.to_json
  end

  get '/total_count' do
    { code: 0, message: 'success', data: Photo.count }.to_json
  end

  post '/like' do
    response['Access-Control-Allow-Origin'] = '*'
    current_user = User.find_or_create_by(uniq_token: params[:uniq_token]) if params[:uniq_token]

    photo = Photo.find params[:id]
    if current_user
      current_user.like photo
    else
      photo.inc(like_count: 1)
    end
    { code: 0, message: 'success', data: photo }.to_json
  end

  get '/list' do
    User.find_or_create_by(uniq_token: params[:uniq_token]) if params[:uniq_token]

    limit = params[:limit] ? params[:limit].to_i : 100
    offset = params[:offset] ? params[:offset].to_i : 0

    @photos = Photo.offset(offset).limit(limit).to_a.each{ |p| p.url << "!retina" }
    { code: 0, message: 'success', data: @photos.shuffle }.to_json
  end

  post '/report/:id' do
    current_user = User.find_or_create_by(uniq_token: params[:uniq_token]) if params[:uniq_token]
    photo = Photo.find params[:id]
    if current_user
      current_user.report photo
    else
      photo.get_reported
    end
    { code: 0, message: 'success', data: true }.to_json
  end

  post '/notlike' do
    response['Access-Control-Allow-Origin'] = '*'
    current_user = User.find_or_create_by(uniq_token: params[:uniq_token]) if params[:uniq_token]

    photo = Photo.find params[:id]
    if current_user
      current_user.notlike photo
    else
      photo.inc(like_count: -1)
    end
    { code: 0, message: 'success', data: photo }.to_json
  end

  ############# these are APIs for mobile clients ############

  ############# these are for PC web ############

  get '/submit' do
    erb :submit
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

  get '/report_list' do
    offset = params[:offset] || 0
    limit = params[:limit] || 100
    @photos = Photo.reported.desc(:reported).offset(offset).limit(limit)
    erb :delete
  end

  get '/delete/:id' do
    photo = Photo.find params[:id]
    res = photo.destroy
    { success: true }.to_json
  end

  ############# these are for PC web ############
end
