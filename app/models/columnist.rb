class Columnist < ApplicationRecord
  include Rolifiable

  belongs_to :user, optional: false
  belongs_to :columnist_title
  has_many :columnist_knowledges, dependent: :destroy
  has_many :knowledge_areas, through: :columnist_knowledges

  validates :user_id, presence: true, uniqueness: true

  enum admin_validate: [:enabled, :disabled]

  has_attached_file(
    :avatar,
    styles: { large: "170x170>", medium: "140x140>", thumb: "27x27>" },
    default_url: "/images/user.png"
  )

  scope :activated, -> { where(admin_validate: :enabled) }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  rails_admin do
    object_label_method :columnist_name_for_admin
  end

  def title
    columnist_title.try(:title)
  end

  def columnist_name
    "#{title} #{user.profile.name}"
  end

  def columnist_name_for_admin
    return "" if user.nil?
    "#{user.email} - #{user.profile.name}"
  end
end
