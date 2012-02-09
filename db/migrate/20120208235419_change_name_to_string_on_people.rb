class ChangeNameToStringOnPeople < ActiveRecord::Migration
  def up
    change_column :people, :name, :string
  end

  def down
    change_column :people, :name, :integer
  end
end
