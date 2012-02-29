class DropPlaceComments < ActiveRecord::Migration
  def self.up
    drop_table :place_comments
  end

  def self.down
    create_table :place_comments
  end
end
