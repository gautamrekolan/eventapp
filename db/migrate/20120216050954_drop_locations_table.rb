class DropLocationsTable < ActiveRecord::Migration
  def self.up
    drop_table :locations
  end

  def self.down
    create_table :locations
  end
end
