class Telephone < ApplicationRecord
  belongs_to :user
  has_many :phonebooks
  has_many :users, through: :phonebooks
end
