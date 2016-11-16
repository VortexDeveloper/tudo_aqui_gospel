class Announcer < ApplicationRecord
  include Rolifiable

  belongs_to :user
  validates :email, :doc, :doc_type, presence: true, on: :update
  enum doc: [:cnpj, :cpf]
end
