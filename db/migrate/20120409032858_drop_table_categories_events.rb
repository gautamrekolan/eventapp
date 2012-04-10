class DropTableCategoriesEvents < ActiveRecord::Migration
  def up
    drop_table :categories_events
  end

  def down
  end
end
