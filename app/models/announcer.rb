class Announcer < ApplicationRecord
  include Rolifiable

  belongs_to :user
  validates :email, :doc, :doc_type, presence: true, on: :update
  enum doc_type: [:cnpj, :cpf]

  has_attached_file(
    :avatar,
    styles: { medium: "140x140>", thumb: "100x100>" },
    default_url: "../../images/user.png"
  )

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
