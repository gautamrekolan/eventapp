class AddUserIdAndEventIdToGoingTo < ActiveRecord::Migration
  def self.up
    add_column :going_tos, :user_id, :integer
    add_column :going_tos, :event_id, :integer
  end

  def self.down
    remove_column :going_tos, :user_id
    remove_column :going_tos, :event_id
  end
end
