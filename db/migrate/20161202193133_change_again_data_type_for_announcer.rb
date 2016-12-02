class ChangeAgainDataTypeForAnnouncer < ActiveRecord::Migration[5.0]
  def change
    change_column :announcers, :doc_type,  :integer
  end
end
