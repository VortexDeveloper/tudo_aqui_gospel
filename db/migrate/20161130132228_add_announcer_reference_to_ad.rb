class AddAnnouncerReferenceToAd < ActiveRecord::Migration[5.0]
  def change
    add_reference :ads, :announcer, foreign_key: true
  end
end
