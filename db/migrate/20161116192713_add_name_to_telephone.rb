class AddNameToTelephone < ActiveRecord::Migration[5.0]
  def change
    add_column :telephones, :name, :string
  end
end
