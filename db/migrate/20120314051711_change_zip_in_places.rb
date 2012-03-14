class ChangeZipInPlaces < ActiveRecord::Migration
  def up
    change_table :places do |t|
      t.change :zip, :string
    end
  end

  def down
    change_table :places do |t|
      t.change :zip, :integer
    end
  end
end
