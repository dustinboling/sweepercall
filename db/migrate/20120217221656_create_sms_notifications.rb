class CreateSmsNotifications < ActiveRecord::Migration
  def change
    create_table :sms_notifications do |t|
      t.integer :agent_id
      t.string :message

      t.timestamps
    end
    add_index :sms_notifications, :agent_id
  end
end
