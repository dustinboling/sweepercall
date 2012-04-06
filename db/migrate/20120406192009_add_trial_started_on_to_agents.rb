class AddTrialStartedOnToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :trial_started_on, :datetime
  end
end
