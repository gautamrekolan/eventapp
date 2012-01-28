class RemoveLikesFromEventLikes < ActiveRecord::Migration
  def self.up
    remove_column :event_likes, :likes
  end

  def self.down
    add_column :event_likes, :likes
  end
end
