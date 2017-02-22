class ChangeSubscriptionPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :subscription_plans, :expire, :integer, default: 0, limit: 1
    add_column :subscription_plans, :trial_duration, :integer, default: 0
    add_column :subscription_plans, :code, :string, null: false
  end
end
