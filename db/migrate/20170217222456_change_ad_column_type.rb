class ChangeAdColumnType < ActiveRecord::Migration[5.0]
  def change
    change_column :ads, :price, :decimal
  end
end
