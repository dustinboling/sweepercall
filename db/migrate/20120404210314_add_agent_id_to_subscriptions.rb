class AddAgentIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :agent_id, :integer
  end
end
