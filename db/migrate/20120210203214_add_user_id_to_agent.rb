class AddUserIdToAgent < ActiveRecord::Migration
  def change
    add_column :agents, :user_id, :integer
    add_index :agents, :user_id
  end
end
