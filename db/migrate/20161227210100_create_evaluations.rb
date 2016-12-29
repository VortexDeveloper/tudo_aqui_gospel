class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.string :comment

      t.timestamps
    end
  end
end
