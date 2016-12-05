class CreateVersicles < ActiveRecord::Migration[5.0]
  def change
    create_table :versicles do |t|
      t.string :testament
      t.string :book
      t.string :chapter
      t.string :versicle
      t.string :text
      t.date :show_day

      t.timestamps
    end
  end
end
