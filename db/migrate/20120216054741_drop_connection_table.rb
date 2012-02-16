class DropConnectionTable < ActiveRecord::Migration
  def self.up
    drop_table :connections
  end

  def self.down
    create_table :connections
  end
end
