class AddColumnsToAnnouncer < ActiveRecord::Migration[5.0]
  def change
    add_column :announcers, :name, :string
    add_column :announcers, :fantasy_name, :string
    add_column :announcers, :contact_name, :string
    add_column :announcers, :doc_type, :integer
    add_column :announcers, :doc, :string
    add_column :announcers, :email, :string
  end
end
