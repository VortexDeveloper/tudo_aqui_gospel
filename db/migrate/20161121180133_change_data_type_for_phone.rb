class ChangeDataTypeForPhone < ActiveRecord::Migration[5.0]
  def change
    change_column :contacts, :phone,  :string
  end
end
