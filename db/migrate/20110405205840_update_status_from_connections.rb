class UpdateStatusFromConnections < ActiveRecord::Migration
  def self.up
    change_column :connections, :status, :integer
  end

  def self.down
  end
end
