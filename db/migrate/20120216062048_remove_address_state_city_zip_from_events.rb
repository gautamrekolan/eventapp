class RemoveAddressStateCityZipFromEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, :address
    remove_column :events, :state
    remove_column :events, :city
    remove_column :events, :zip
  end

  def self.down
    add_column :events, :address, :string
    add_column :events, :state, :string
    add_column :events, :city, :string
    add_column :events, :zip, :integer
  end
end
