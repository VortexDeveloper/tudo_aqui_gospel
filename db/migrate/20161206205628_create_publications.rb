class CreatePublications < ActiveRecord::Migration[5.0]
  def change
    create_table :publications do |t|
      t.string :title
      t.string :description
      t.text :body
      t.integer :pub_type, limit: 1
      t.integer :pub_category
      t.references :knowledge_area, foreign_key: true

      t.timestamps
    end
  end
end
