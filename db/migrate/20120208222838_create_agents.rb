class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :phone
      t.text :website_url

      t.timestamps
    end
  end
end
