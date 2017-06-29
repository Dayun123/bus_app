class Location < ApplicationRecord

  geocoded_by :full_street_address
  after_validation :geocode

  MARTA_CITIES = [
    'Atlanta',
    'Alpharetta',
    'Avondale Estates',
    'Chamblee',
    'Clarkston',
    'College Park',
    'Decatur',
    'Doraville',
    'Dunwoody',
    'East Point',
    'Ellenwood',
    'Fairburn',
    'Forest Park',
    'Hapeville',
    'Jonesboro',
    'Lake City',
    'Lovejoy',
    'Lithonia',
    'Morrow',
    'Palmetto',
    'Riverdale',
    'Roswell',
    'Sandy Springs',
    'Stone Mountain',
    'Union City'
  ]

  def full_street_address
    "#{:street_address}, #{city}, GA"
  end

end

# == Schema Information
#
# Table name: locations
#
#  id                      :integer          not null, primary key
#  street_address          :string
#  city                    :string
#  latitude                :float
#  longitude               :float
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  acceptable_bus_distance :float
#
