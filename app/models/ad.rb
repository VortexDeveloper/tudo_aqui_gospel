class Ad < ApplicationRecord
  belongs_to :announcer, optional: false
  belongs_to :category, optional: false
  enum ad_type: [:principal, :banner, :normal]
  enum home: [:s, :n]
  enum active: [:sim, :nao]

  has_attached_file(
    :avatar,
    styles: { large: "800x640>" ,medium: "370x320", thumb: "170x170>" },
    default_url: "../../images/user.png"
  )

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
