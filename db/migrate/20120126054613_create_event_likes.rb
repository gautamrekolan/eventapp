class CreateEventLikes < ActiveRecord::Migration
  def self.up
    create_table :event_likes do |t|
      t.integer :event_id
      t.integer :likes

      t.timestamps
    end
  end

  def self.down
    drop_table :event_likes
  end
end
