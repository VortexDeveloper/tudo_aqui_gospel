class CreateColumnistKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :columnist_knowledges do |t|
      t.references :columnist, foreign_key: true
      t.references :knowledge_area, foreign_key: true

      t.timestamps
    end
  end
end
