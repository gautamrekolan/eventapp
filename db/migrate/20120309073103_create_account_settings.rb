class CreateAccountSettings < ActiveRecord::Migration
  def change
    create_table :account_settings do |t|
      
      t.boolean :profile_is_public
      
      t.timestamps
    end
  end
  
  def self.down 
    drop_table :account_settings
  end
end
