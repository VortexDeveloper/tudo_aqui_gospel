class AddNameToColumnist < ActiveRecord::Migration[5.0]
  def change
    add_column :columnists, :name, :string
  end
end
