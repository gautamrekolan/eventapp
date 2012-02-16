class RemoveLocationFromEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, :location
  end

  def self.down
    create_column :events, :location, :string
  end
end
