class CreatePubAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :pub_attachments do |t|
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
