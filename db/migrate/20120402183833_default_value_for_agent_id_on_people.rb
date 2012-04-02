class DefaultValueForAgentIdOnPeople < ActiveRecord::Migration
  def up
    change_column :people, :agent_id, :integer, :default => 12
  end

  def down
    change_column :people, :agent_id, :integer, :default => nil
  end
end
