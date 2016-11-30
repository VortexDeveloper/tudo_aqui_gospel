class Ad < ApplicationRecord
  belongs_to :announcer
  belongs_to :category

  has_attached_file(
    :avatar,
    styles: { medium: "140x140>", thumb: "100x100>" },
    default_url: "../../images/user.png"
  )

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

end
