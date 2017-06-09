class Curriculum < ApplicationRecord

  belongs_to :subscriber

  has_attached_file :file
  # validates_attachment_content_type :file, content_type: [
  #   'application/pdf',
  #   'application/x-rar',
  #   'application/doc',
  #   'application/xls',
  #   'application/docx',
  #   'application/xlsx',
  #   /\Aimage\/.*\z/
  # ]

  validates_attachment :file, :content_type => {
    :content_type =>
      %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)
  }

  rails_admin do
    object_label_method :subscriber_label_name
  end

end
