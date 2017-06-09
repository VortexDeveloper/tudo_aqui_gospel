class Telephone < ApplicationRecord
  belongs_to :personal_profile
  has_many :phonebooks, dependent: :destroy
  has_many :personal_profiles, through: :phonebooks, dependent: :destroy

  enum main_telephone: [:not_main, :main]
end
