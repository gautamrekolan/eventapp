class CreateCategoriesEvents < ActiveRecord::Migration
  def self.up
    create_table :categories_events, :id => false do |t|
	  t.references :category
	  t.references :event 
	end
  end

  def self.down
    drop_table :categories_events
  end
end
