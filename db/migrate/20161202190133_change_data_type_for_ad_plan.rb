class ChangeDataTypeForAdPlan < ActiveRecord::Migration[5.0]
  def change
    change_column :ad_plans, :type, 'integer USING CAST(type AS integer)'
  end
end
