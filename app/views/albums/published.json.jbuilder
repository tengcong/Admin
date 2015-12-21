json.array!(@collection) do |album|
  # json.extract! bq_package, :id
  json.id album.id.to_s
  json.name album.title
  json.thumbnail album.thumbnail
end
