class CreateEventsCategories < ActiveRecord::Migration
  def self.up
    create_table :events_categories, :id => false do |t| 
	  t.references :event 
	  t.references :category
    end
  end

  def self.down
  end
end
