class AddUserIdToEventLikes < ActiveRecord::Migration
  def self.up
    add_column :event_likes, :user_id, :integer
  end

  def self.down
    remove_column :event_likes, :user_id
  end
end
