class AddAttachmentToPubAttachments < ActiveRecord::Migration[5.0]
  def change
    add_attachment :pub_attachments, :file
  end
end
