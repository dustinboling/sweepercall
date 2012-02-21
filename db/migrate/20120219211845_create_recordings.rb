class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.integer :agent_id
      t.text :recording_url
      t.boolean :active

      t.timestamps
    end
  end
end
