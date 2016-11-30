class AddAttachmentAvatarToAds < ActiveRecord::Migration
  def self.up
    change_table :ads do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :ads, :avatar
  end
end
