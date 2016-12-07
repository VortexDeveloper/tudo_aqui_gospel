class AddMooreColumnsToAd < ActiveRecord::Migration[5.0]
  def change
    add_column :ads, :active, :integer
  end
end
