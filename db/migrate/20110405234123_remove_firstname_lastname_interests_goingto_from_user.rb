class RemoveFirstnameLastnameInterestsGoingtoFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :firstname
    remove_column :users, :lastname
    remove_column :users, :interests
    remove_column :users, :goingto
  end

  def self.down
    add_column :users, :goingto, :string
    add_column :users, :interests, :string
    add_column :users, :lastname, :string
    add_column :users, :firstname, :string
  end
end
