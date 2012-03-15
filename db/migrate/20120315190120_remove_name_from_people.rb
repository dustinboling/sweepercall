class RemoveNameFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :name
  end

  def down
    remove_column :people, :name, :string
  end
end
