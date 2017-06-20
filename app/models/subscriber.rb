class Subscriber < ApplicationRecord
  include Rolifiable

  belongs_to :user, optional: false
  has_one :curriculum, dependent: :destroy

  validates :user_id, presence: true, uniqueness: true

  has_attached_file(
    :avatar,
    styles: { large: "140x140#", medium: "100x100#", thumb: "27x27#" },
    default_url: "/images/user.png"
  )

  rails_admin do
    object_label_method :subscriber_label_name
  end

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def subscriber_label_name
    return "" if user.nil?
    "#{user.email} - #{user.profile.name}"
  end

end
