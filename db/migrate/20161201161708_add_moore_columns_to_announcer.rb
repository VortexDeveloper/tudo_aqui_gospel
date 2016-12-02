class AddMooreColumnsToAnnouncer < ActiveRecord::Migration[5.0]
  def change
    add_column :announcers, :about_text, :string
  end
end
