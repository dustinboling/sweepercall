class CreateEmailReminders < ActiveRecord::Migration
  def change
    create_table :email_reminders do |t|
      t.integer :agent_id
      t.string :name
      t.text :message

      t.timestamps
    end
  end
end
