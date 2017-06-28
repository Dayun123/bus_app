class AddAcceptableBusDistanceToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :acceptable_bus_distance, :float
  end
end
