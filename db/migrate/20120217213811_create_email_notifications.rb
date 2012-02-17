class CreateEmailNotifications < ActiveRecord::Migration
  def change
    create_table :email_notifications do |t|
      t.integer :agent_id
      t.string :title
      t.string :message
      t.boolean :active

      t.timestamps
    end
    add_index :email_notifications, :agent_id
  end
end
