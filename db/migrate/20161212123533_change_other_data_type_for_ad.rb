class ChangeOtherDataTypeForAd < ActiveRecord::Migration[5.0]
  def change
    change_column :ads, :home, 'integer USING CAST(home AS integer)'
  end
end
