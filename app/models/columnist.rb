class Columnist < ApplicationRecord
  include Rolifiable

  belongs_to :user
  belongs_to :columnist_title
  has_many :columnist_knowledges
  has_many :knowledge_areas, through: :columnist_knowledges


  has_attached_file(
    :avatar,
    styles: { medium: "140x140>", thumb: "27x27>" },
    default_url: "../../images/user.png"
  )

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def title
    columnist_title.title
  end

  def columnist_name
    "#{title} #{user.profile.name}"
  end
end
