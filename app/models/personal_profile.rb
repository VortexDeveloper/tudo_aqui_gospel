class PersonalProfile < ApplicationRecord
  belongs_to :city
  belongs_to :state
  belongs_to :country
  belongs_to :user, optional: false

  validates :user_id, presence: true, uniqueness: true
end
