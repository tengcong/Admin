json.data do
  json.id @album.id.to_s
  json.title @album.title
  json.thumbnail @album.thumbnail

  json.photos @photos do |photo|
    json.url photo.url
  end
end
