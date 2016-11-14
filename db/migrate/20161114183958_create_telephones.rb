class CreateTelephones < ActiveRecord::Migration[5.0]
  def change
    create_table :telephones do |t|
      t.references :user, foreign_key: true
      t.string :number

      t.timestamps
    end
  end
end
