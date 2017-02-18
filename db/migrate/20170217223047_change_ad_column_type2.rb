class ChangeAdColumnType2 < ActiveRecord::Migration[5.0]
  def change
    change_column :ads, :price, :decimal, precision: 11, scale: 2
  end
end
