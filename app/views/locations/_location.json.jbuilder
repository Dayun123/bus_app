json.extract! location, :id, :street_address, :city, :latitude, :longitude, :created_at, :updated_at
json.url location_url(location, format: :json)
