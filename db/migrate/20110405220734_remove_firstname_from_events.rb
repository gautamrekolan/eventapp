class RemoveFirstnameFromEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, :firstname
  end

  def self.down
    add_column :events, :firstname, :string
  end
end
