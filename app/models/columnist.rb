class Columnist < ApplicationRecord
  include Rolifiable

  belongs_to :user

  has_attached_file(
    :avatar,
    styles: { medium: "140x140>", thumb: "27x27>" },
    default_url: "../../images/user.png"
  )

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

end
