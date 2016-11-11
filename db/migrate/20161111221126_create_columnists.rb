class CreateColumnists < ActiveRecord::Migration[5.0]
  def change
    create_table :columnists do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
