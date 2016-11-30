class AddAdPlanReferenceToAnnouncer < ActiveRecord::Migration[5.0]
  def change
    add_reference :announcers, :ad_plan, foreign_key: true
  end
end
