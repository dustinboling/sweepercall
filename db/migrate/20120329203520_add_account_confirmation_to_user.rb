class AddAccountConfirmationToUser < ActiveRecord::Migration
  def change
    add_column :users, :account_confirmation, :string
  end
end
