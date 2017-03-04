class AddColumnsToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :last_transaction_code, :string
    add_column :transactions, :last_transaction_status, :integer
    add_column :transactions, :transaction_reference, :string
  end
end
