class Gallery < ApplicationRecord
  belongs_to :announcer

  has_attached_file(
    :image,
    styles: { medium: "370x278>", large: "370x370>" },
    default_url: "../../images/user.png"
  )

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
