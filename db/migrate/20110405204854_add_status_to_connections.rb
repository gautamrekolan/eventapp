class AddStatusToConnections < ActiveRecord::Migration
  def self.up
    add_column :connections, :status, :string
  end

  def self.down
    remove_column :connections, :status
  end
end
