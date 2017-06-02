class RemoveAdminValidateFromColumnist < ActiveRecord::Migration[5.0]
  def change
    remove_column :columnists, :admin_validate, :string
  end
end
