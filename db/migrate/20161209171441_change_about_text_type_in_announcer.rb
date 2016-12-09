class ChangeAboutTextTypeInAnnouncer < ActiveRecord::Migration[5.0]
  def change
    change_column :announcers, :about_text, :text
  end
end
