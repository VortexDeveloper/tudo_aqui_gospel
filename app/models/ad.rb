class Ad < ApplicationRecord
  belongs_to :announcer, optional: false
  belongs_to :category, optional: false
  enum ad_type: [:principal, :banner, :normal]
  enum home: [:s, :n]
  enum active: [:sim, :nao]

  has_attached_file(
    :avatar,
    styles: { large: "800x640>" ,medium: "370x320", thumb: "170x170>" },
    default_url: "/images/user.png"
  )

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  scope :home, ->(show_home) { where(home: 's') if show_home }

  scope :active_banner, ->(args) { where(ad_type: "banner").where('start_date <= :today AND end_date >= :today', today: Date.today).home(args[:home]).shuffle }
  scope :active_side_banner, ->(args) { where(ad_type: "principal").where('start_date <= :today AND end_date >= :today', today: Date.today).home(args[:home]).shuffle }
  scope :active_normal, ->(args) { where(ad_type: "normal").where('start_date <= :today AND end_date >= :today', today: Date.today).home(args[:home]).shuffle }
end
