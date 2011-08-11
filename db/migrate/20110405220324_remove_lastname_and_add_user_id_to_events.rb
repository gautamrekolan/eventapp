class RemoveLastnameAndAddUserIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :user_id, :integer
	remove_column :events, :lastname
  end

  def self.down
    remove_column :events, :user_id
  end
end
