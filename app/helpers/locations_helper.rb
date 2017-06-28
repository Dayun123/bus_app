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

  # Determines whether the bus is close enough to the user to be displayed on the show view.
  def is_nearby?(user_location, bus)

    # The distance in miles for one degree of latitude and longitude in Atlanta, GA. Use this website: http://www.csgnetwork.com/degreelenllavcalc.html and put in the the latitude of Atlanta, GA (33.7490) to see the distance in miles that one degree of latitude and longitude represents.
    distance_one_degree_lat_miles = 68.92101228371666
    distance_one_degree_lon_miles = 57.57340026519574

    # The bus comes to us as a JSON object with string key/value pairs, so convert to float to get accurate calculations. These represent the legs of a right triangle.
    difference_lat = user_location.latitude - bus["LATITUDE"].to_f
    difference_lon = user_location.longitude - bus["LONGITUDE"].to_f

    # Convert the distances from degrees of latitude and longitude to miles so that we can compute the actual distance and the difference bwetween the user and this distance in miles instead of degrees.
    difference_lat_miles = difference_lat * distance_one_degree_lat_miles
    difference_lon_miles = difference_lon * distance_one_degree_lon_miles

    # Pythagorean theorem to find the actual distance in miles, which represents the hypotenuese of a right triangle.
    distance = Math.sqrt(difference_lat_miles ** 2 + difference_lon_miles ** 2)

    # Returns whether the distance of the bus to the user is within our acceptable_bus_distance range.
    distance <= user_location.acceptable_bus_distance
  end

end
