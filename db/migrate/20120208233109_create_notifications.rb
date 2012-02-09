class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :type
      t.integer :day
      t.integer :week
      t.integer :person_id

      t.timestamps
    end
    add_index :notifications, :person_id
  end
end
