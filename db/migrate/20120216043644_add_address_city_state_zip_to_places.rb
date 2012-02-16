class AddAddressCityStateZipToPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :address, :string
    add_column :places, :state, :string
    add_column :places, :city, :string
    add_column :places, :zip, :integer
    add_column :places, :lat, :float
    add_column :places, :lng, :float
  end

  def self.down
    remove_column :places, :address
    remove_column :places, :state
    remove_column :places, :city
    remove_column :places, :zip
    remove_column :places, :lat
    remove_column :places, :lng
  end
end
