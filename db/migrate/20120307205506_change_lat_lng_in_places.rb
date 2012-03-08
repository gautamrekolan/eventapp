class ChangeLatLngInPlaces < ActiveRecord::Migration
  def up
    rename_column :places, :lat, :latitude
    rename_column :places, :lng, :longitude
  end

  def down
  end
end
