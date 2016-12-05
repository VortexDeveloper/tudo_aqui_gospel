class ChangeMooreColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :ads, :type, :ad_type
  end
end
