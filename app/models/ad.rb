class Ad < ApplicationRecord
  belongs_to :announcer
  belongs_to :category
  enum ad_type: [:principal, :banner, :normal]
  enum home: [:s, :n]
  enum active: [:sim, :nao]

  has_attached_file(
    :avatar,
    styles: { large: "800x640>" ,medium: "370x320", thumb: "170x170>" },
    default_url: "../../images/user.png"
  )

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def enable_ad
    self.active = "sim"
    self.save
  end

  def disable_ad
    self.active = "nao"
    self.save
  end
end
