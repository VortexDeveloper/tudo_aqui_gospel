class AddAttachmentBannerToAnnouncers < ActiveRecord::Migration
  def self.up
    change_table :announcers do |t|
      t.attachment :banner
    end
  end

  def self.down
    remove_attachment :announcers, :banner
  end
end
