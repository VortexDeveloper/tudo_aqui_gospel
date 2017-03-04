class RenameColumnStatusToSubscriptionStatusInTransaction < ActiveRecord::Migration[5.0]
  def change
    rename_column :transactions, :status, :subscription_status
  end
end
