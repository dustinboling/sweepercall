class AddActiveToSmsNotifications < ActiveRecord::Migration
  def change
    add_column :sms_notifications, :active, :boolean
  end
end
