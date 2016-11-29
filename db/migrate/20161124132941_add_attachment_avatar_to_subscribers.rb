class AddAttachmentAvatarToSubscribers < ActiveRecord::Migration
  def self.up
    change_table :subscribers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :subscribers, :avatar
  end
end
