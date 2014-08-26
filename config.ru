require './server.rb'

configure do
  enable :cross_origin
end

run App
