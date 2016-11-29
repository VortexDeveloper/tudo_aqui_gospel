class AddAttachmentAvatarToAnnouncers < ActiveRecord::Migration
  def self.up
    change_table :announcers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :announcers, :avatar
  end
end
