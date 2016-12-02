class AddColumnsToAd < ActiveRecord::Migration[5.0]
  def change
    add_column :ads, :type, :string
    add_column :ads, :home, :string
  end
end
