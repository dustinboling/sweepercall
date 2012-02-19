class ChangePhoneOnAgents < ActiveRecord::Migration
  def up
    change_column :agents, :phone, :bigint
  end

  def down
    change_column :agents, :phone, :integer
  end
end
