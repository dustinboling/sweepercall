class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :phone
      t.integer :mobile_phone
      t.integer :name
      t.integer :agent_id

      t.timestamps
    end
    add_index :people, :agent_id
  end
end
