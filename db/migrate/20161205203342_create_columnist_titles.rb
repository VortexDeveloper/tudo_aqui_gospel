class CreateColumnistTitles < ActiveRecord::Migration[5.0]
  def change
    create_table :columnist_titles do |t|
      t.string :title

      t.timestamps
    end
  end
end
