class PersonalProfile < ApplicationRecord
  belongs_to :city
  belongs_to :state
  belongs_to :country
  belongs_to :user, optional: false
  has_many :phonebooks, dependent: :destroy
  has_many :telephones, through: :phonebooks, dependent: :destroy

  validates :user_id, presence: true, uniqueness: true

  delegate :uf, to: :state, prefix: true, allow_nil: true
  delegate :name, to: :city, prefix: true, allow_nil: true
  delegate :code, to: :country, prefix: true, allow_nil: true

  def main_phone
    main_phone = telephones.where(main_telephone: :main)
    return main_phone.first if main_phone.present?
    telephones.first
  end
end
