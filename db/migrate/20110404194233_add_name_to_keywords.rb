class AddNameToKeywords < ActiveRecord::Migration
  def self.up
    add_column :keywords, :name, :string
  end

  def self.down
    remove_column :keywords, :name
  end
end
