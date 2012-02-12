class RemoveEmailFromAgents < ActiveRecord::Migration
  def up
    remove_column :agents, :email
  end

  def down
    add_column :agents, :email, :string
  end
end
