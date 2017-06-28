class Location < ApplicationRecord

  geocoded_by :full_street_address
  after_validation :geocode

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
