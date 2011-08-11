class AddEmailAndPasswordToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string
    add_column :users, :password, :string
  end

  def self.down
    remove_column :users, :password
    remove_column :users, :email
  end
end
