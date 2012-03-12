class RemoveUsernameAddFirstnameLastnameZipToUsers < ActiveRecord::Migration
  def up
    remove_column :users, :username
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :zip, :string
  end

  def down
    add_column :users, :username, :string
    remove_column :users, :firstname
    remove_column :users, :lastname
    remove_column :users, :zip
  end
end
