class AddAnnouncerReferenceToGallery < ActiveRecord::Migration[5.0]
  def change
    add_reference :galleries, :announcer, foreign_key: true
  end
end
