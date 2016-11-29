class AddAttachmentAvatarToColumnists < ActiveRecord::Migration
  def self.up
    change_table :columnists do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :columnists, :avatar
  end
end
