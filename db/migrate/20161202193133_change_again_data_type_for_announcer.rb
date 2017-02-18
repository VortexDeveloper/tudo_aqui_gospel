class ChangeAgainDataTypeForAnnouncer < ActiveRecord::Migration[5.0]
  def change
    change_column :announcers, :doc_type, 'integer USING CAST(doc_type AS integer)'
  end
end
