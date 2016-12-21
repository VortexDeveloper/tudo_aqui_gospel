class Subscriber < ApplicationRecord
  include Rolifiable

  belongs_to :user, optional: false
  has_one :curriculum

  validates :curriculum, uniqueness: true

  validates :user_id, presence: true, uniqueness: true

  has_attached_file(
    :avatar,
    styles: { large: "140x140>", medium: "100x100>", thumb: "27x27>" },
    default_url: "../../images/user.png"
  )

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

end
