class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :ad_plans, :type, :plan_type
  end
end
