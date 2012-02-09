class AddUniqueForEmailOnPeopleAndAgents < ActiveRecord::Migration
  def up
    add_index :people, :email, :unique => true
    add_index :agents, :email, :unique => true
  end

  def down
    remove_index :people, :email
    remove_index :agents, :email
  end
end