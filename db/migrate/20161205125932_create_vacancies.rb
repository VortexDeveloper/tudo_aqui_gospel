class CreateVacancies < ActiveRecord::Migration[5.0]
  def change
    create_table :vacancies do |t|
      t.string :name
      t.string :description
      t.string :active

      t.timestamps
    end
  end
end
