class ChangeDataTypeForAd < ActiveRecord::Migration[5.0]
  def change
    change_column :ads, :type,  :integer
  end
end
