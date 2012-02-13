class AddUuidToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :uuid, :string
    add_index :agents, :uuid, :unique => true
  end
end