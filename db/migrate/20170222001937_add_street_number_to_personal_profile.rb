class AddStreetNumberToPersonalProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :personal_profiles, :street_number, :string
  end
end
