class ChangePhoneToStringOnAgents < ActiveRecord::Migration
  def up
    change_column :agents, :phone, :string
  end

  def down
    change_column :agents, :phone, :integer
  end
  
end
