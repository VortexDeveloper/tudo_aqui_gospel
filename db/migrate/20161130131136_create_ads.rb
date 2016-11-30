class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.string :description
      t.string :title
      t.string :link
      t.string :text_description
      t.date :start_date
      t.date :end_date
      t.date :record_date
      t.integer :price

      t.timestamps
    end
  end
end
