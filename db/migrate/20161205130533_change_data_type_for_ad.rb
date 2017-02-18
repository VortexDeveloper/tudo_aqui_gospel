class ChangeDataTypeForAd < ActiveRecord::Migration[5.0]
  def change
    change_column :ads, :type, 'integer USING CAST(type AS integer)'
  end
end
