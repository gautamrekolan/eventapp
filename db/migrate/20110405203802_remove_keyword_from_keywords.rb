class RemoveKeywordFromKeywords < ActiveRecord::Migration
  def self.up
    remove_column :keywords, :keyword
  end

  def self.down
    add_column :keywords, :keyword, :string
  end
end
