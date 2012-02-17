class ChangeMessageToTextOnEmailNotifications < ActiveRecord::Migration
  def up
    change_column :email_notifications, :message, :text
  end

  def down
    change_column :email_notifications, :message, :string
  end
end
