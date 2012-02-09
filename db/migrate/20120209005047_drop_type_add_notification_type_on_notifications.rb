class DropTypeAddNotificationTypeOnNotifications < ActiveRecord::Migration
  def up
    remove_column :notifications, :type
    add_column :notifications, :notification_type, :integer
  end

  def down
    remove_column :notifications, :notification_type
    add_column :notifications, :type, :integer
  end
end
