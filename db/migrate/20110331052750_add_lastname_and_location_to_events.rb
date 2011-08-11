class AddLastnameAndLocationToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :lastname, :string
    add_column :events, :location, :string
  end

  def self.down
    remove_column :events, :location
    remove_column :events, :lastname
  end
end
