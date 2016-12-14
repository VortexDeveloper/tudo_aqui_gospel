class Telephone < ApplicationRecord
  belongs_to :personal_profile
  has_many :phonebooks
  has_many :personal_profiles, through: :phonebooks
end
