class ChangePhoneNumbersToStrings < ActiveRecord::Migration
  def up
    change_column :people, :phone, :string
    change_column :people, :mobile_phone, :string
  end

  def down
    change_column :people, :phone, :integer
    change_column :people, :mobile_phone, :integer
  end
end
