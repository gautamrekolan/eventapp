class AddFirstnameToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :firstname, :string
  end

  def self.down
    remove_column :events, :firstname
  end
end
