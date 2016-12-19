class AddSubscriberReferenceToCurriculum < ActiveRecord::Migration[5.0]
  def change
    add_reference :curriculums, :subscriber, foreign_key: true
  end
end
