class AddAttachmentToCurriculums < ActiveRecord::Migration[5.0]
  def change
    add_attachment :curriculums, :file
  end
end
