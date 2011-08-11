class CreateGoingTos < ActiveRecord::Migration
  def self.up
    create_table :going_tos do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :going_tos
  end
end
