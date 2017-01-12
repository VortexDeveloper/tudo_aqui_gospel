class ChangeDescriptionFieldInCurriculum < ActiveRecord::Migration[5.0]
  def change
    change_column :curriculums, :description, :text
  end
end
