class AddAdminValidateToColumnist < ActiveRecord::Migration[5.0]
  def change
    add_column :columnists, :admin_validate, :integer
  end
end
