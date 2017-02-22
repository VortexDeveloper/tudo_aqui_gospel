class ChangeSubscriptionPlanToPlanInTransaction < ActiveRecord::Migration[5.0]
  def change
    rename_column :transactions, :subscription_plan_id, :plan_id
  end
end
