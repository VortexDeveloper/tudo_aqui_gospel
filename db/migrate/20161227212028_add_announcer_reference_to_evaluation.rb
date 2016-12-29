class AddAnnouncerReferenceToEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_reference :evaluations, :announcer, foreign_key: true
  end
end
