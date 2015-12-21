json.extract! @album, :id, :created_at, :updated_at

json.id @album.id.to_s
json.title @album.title
json.thumbnail @album.thumbnail

json.photos @photos do |photo|
  json.url photo.url
end
