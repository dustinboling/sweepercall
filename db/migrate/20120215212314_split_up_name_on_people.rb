class SplitUpNameOnPeople < ActiveRecord::Migration
  def up
    add_column :people, :first_name, :string
    add_column :people, :last_name, :string
  end

  def down
    remove_column :people, :first_name
    remove_column :people, :last_name
  end
end