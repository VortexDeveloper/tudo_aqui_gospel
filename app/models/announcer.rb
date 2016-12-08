class Announcer < ApplicationRecord
  include Rolifiable
  has_many :ads
  has_many :photos, class_name: "Gallery"
  has_many :vacancies
  belongs_to :ad_plan
  belongs_to :user, optional: false

  validates :user_id, presence: true, uniqueness: true
  validates :email, :doc, :doc_type, presence: true, on: :update
  
  enum doc_type: [:cnpj, :cpf]

  has_attached_file(
    :avatar,
    styles: { medium: "140x140>", thumb: "100x100>" },
    default_url: "../../images/user.png"
  )

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_attached_file(
    :banner,
    styles: { normal: "800x370>", medium: "555x150>", thumb: "100x100>" },
    default_url: "../../images/banner.png"
  )

  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\z/

end
