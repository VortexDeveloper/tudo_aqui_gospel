class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :company
      t.integer :phone
      t.string :message

      t.timestamps
    end
  end
end
