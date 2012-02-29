class CreatePlaceComments < ActiveRecord::Migration
  def up
    create_table :place_comments do |t|
      t.integer :place_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end

  def down
    drop_table :place_comments
  end
end
