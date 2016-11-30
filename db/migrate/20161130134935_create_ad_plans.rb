class CreateAdPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :ad_plans do |t|
      t.string :comercial
      t.string :name
      t.integer :days
      t.integer :value
      t.date :start_date
      t.date :end_date
      t.string :type
      t.string :description

      t.timestamps
    end
  end
end
