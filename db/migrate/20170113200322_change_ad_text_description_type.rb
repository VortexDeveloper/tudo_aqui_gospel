class ChangeAdTextDescriptionType < ActiveRecord::Migration[5.0]
  def change
    change_column :ads, :text_description, :text
  end
end
