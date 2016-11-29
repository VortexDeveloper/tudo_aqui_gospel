class ChangeDataTypeForAnnouncer < ActiveRecord::Migration[5.0]
  def change
    change_column :announcers, :doc_type,  :string
  end
end
