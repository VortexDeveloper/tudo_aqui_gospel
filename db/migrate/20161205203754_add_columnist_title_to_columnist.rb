class AddColumnistTitleToColumnist < ActiveRecord::Migration[5.0]
  def change
    add_reference :columnists, :columnist_title, foreign_key: true
  end
end
