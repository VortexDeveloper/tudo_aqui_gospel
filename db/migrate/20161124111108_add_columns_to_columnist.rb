class AddColumnsToColumnist < ActiveRecord::Migration[5.0]
  def change
    add_column :columnists, :periodicity, :string
    add_column :columnists, :admin_info, :string
    add_column :columnists, :birth_date, :date
    add_column :columnists, :sex, :string
    add_column :columnists, :admin_validate, :string
  end
end
