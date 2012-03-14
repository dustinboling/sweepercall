class AddOutgoingPhoneToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :outgoing_phone, :string
  end
end
