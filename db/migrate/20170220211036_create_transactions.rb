class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.references :subscription_plan, foreign_key: true
      t.integer :status
      t.string :subscription_code

      t.timestamps
    end
  end
end
