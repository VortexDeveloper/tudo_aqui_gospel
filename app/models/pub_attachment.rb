class PubAttachment < ApplicationRecord
  belongs_to :publication

  has_attached_file :file
  validates_attachment_content_type :file, content_type: [
    'application/pdf',
    "application/force-download",
    'application/x-rar',
    'application/doc',
    'application/msword',
    'application/vnd.ms-office',
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    /\Aimage\/.*\z/
  ]
end
