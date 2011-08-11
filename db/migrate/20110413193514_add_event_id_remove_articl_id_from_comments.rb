class AddEventIdRemoveArticlIdFromComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :event_id, :integer
	remove_column :comments, :articl_id
  end

  def self.down
    remove_column :comments, :event_id
  end
end
