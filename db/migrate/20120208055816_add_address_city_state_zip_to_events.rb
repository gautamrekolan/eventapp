class AddAddressCityStateZipToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :address, :string
    add_column :events, :state, :string
    add_column :events, :city, :string
    add_column :events, :zip, :integer
  end

  def self.down
    remove_column :events, :zip
    remove_column :events, :city
    remove_column :events, :state
    remove_column :events, :address
  end
end
