class ChangePhoneToStringOnPeople < ActiveRecord::Migration
  def up
    change_column :people, :phone, :string
  end

  def down
    change_column :people, :phone, :integer
  end
  
end
