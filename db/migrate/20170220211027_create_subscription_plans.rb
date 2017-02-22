class CreateSubscriptionPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :subscription_plans do |t|
      t.string :reference
      t.string :name
      t.string :details
      t.string :period
      t.integer :duration_in_months
      t.string :price

      t.timestamps
    end
  end
end
