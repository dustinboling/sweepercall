class AddAccountConfirmedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_confirmed_at, :date
  end
end
