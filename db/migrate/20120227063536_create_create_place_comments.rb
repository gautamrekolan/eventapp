class CreateCreatePlaceComments < ActiveRecord::Migration
  #the name of this class is fucked because i called rails g model 'create_place_comments'
  def self.up
    create_table :place_comments do |t|
      t.integer :user_id
      t.integer :place_id
      t.text :body
      t.timestamps
    end
  end
  
  def self.down
    drop_table :place_comments
  end
end
