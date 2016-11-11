class CreateSubscribers < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribers do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
