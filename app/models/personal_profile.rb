class PersonalProfile < ApplicationRecord
  belongs_to :city
  belongs_to :state
  belongs_to :country
  belongs_to :user, optional: false
  has_many :phonebooks
  has_many :telephones, through: :phonebooks

  validates :user_id, presence: true, uniqueness: true
end
