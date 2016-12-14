class Phonebook < ApplicationRecord
  belongs_to :personal_profile
  belongs_to :telephone
end
