class ChangeDayAndWeekFieldsOnNotifications < ActiveRecord::Migration
  def up
    change_column :notifications, :day, :string
    change_column :notifications, :week, :string
  end

  def down
    change_column :notifications, :day, :integer
    change_column :notifications, :week, :integer
  end
end
