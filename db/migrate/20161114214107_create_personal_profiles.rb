class CreatePersonalProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :personal_profiles do |t|
      t.string :name
      t.string :street
      t.string :complement
      t.string :neighborhood
      t.references :city, foreign_key: true
      t.references :state, foreign_key: true
      t.references :country, foreign_key: true
      t.string :zip_code

      t.timestamps
    end
  end
end
