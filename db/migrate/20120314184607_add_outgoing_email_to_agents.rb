class AddOutgoingEmailToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :outgoing_email, :string
  end
end
