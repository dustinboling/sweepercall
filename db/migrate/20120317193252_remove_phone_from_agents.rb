class RemovePhoneFromAgents < ActiveRecord::Migration
  def up
    remove_column :agents, :phone
  end

  def down
    add_column :agents, :phone, :string
  end
end
