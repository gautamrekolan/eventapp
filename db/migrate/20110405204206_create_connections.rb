class CreateConnections < ActiveRecord::Migration
  def self.up
    create_table :connections do |t|
    
	t.integer :asking_user_id
	t.integer :asked_user_id
	
      t.timestamps
    end
  end

  def self.down
    drop_table :connections
  end
end
