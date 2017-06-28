module LocationsHelper

  # Gets all the busses from the ATL bus API
  def get_all_busses_from_api(bus_api_url)
    # Sends an HTTP request to bus_api_url and stores response in res
    res = Net::HTTP.get_response(URI.parse(bus_api_url))

    # We only need the body of the response, this will be a giant string that holds JSON objects
    bus_data = res.body

    # bus_data is a string of JSON objects, this will return an array of JSON objects to the caller of the method.
    JSON.parse(bus_data)
  end

  # Determines whether the bus is
  def is_nearby?(user_location, bus)

    # The distance in degrees that we will allow a bus to be considered close to us from. Use this website: http://www.csgnetwork.com/degreelenllavcalc.html and put in the the latitude of Atlanta, GA to see the distance in miles that one degree of latitude and longitude represents. 0.2 represents about 1 and a 1/2 miles in distance.
    max_distance = 0.02

    # The bus comes to us as a JSON object with string key/value pairs, so convert to float to get accurate calculations. These represent the legs of a right triangle.
    difference_lat = user_location.latitude - bus["LATITUDE"].to_f
    difference_lon = user_location.longitude - bus["LONGITUDE"].to_f

    # Pythagorean theorem to find the actual distance, which represents the hypotenuese of a right triangle.
    distance = Math.sqrt(difference_lat ** 2 + difference_lon ** 2)

    # Returns whether the distance of the bus to the user is within our max_distance range
    distance <= max_distance
  end

end
