module LocationsHelper

  # Gets all the busses from the ATL bus API
  def get_all_busses_from_api(bus_api_url)
    # Sends an HTTP request to bus_api_url and stores response in raw_http
    raw_http = Net::HTTP.get_response(URI.parse(bus_api_url))

    # We only need the body of the response
    bus_data = raw_http.body

    # Spits it out as JSON
    JSON.parse(bus_data)
  end

  def is_nearby?(user_lat, user_lon, bus_lat, bus_lon)

    # The distance in degrees that we will allow a bus to be considered close to us from. Use this website: http://www.csgnetwork.com/degreelenllavcalc.html
    max_distance = 0.02

    difference_lat = user_lat - bus_lat.to_f
    difference_lon = user_lon - bus_lon.to_f

    # Pythagorean theorem to find the actual distance
    distance = Math.sqrt(difference_lat ** 2 + difference_lon ** 2)

    # Returns whether the distance of the bus to the user is within our max_distance range
    distance <= max_distance
  end

end
