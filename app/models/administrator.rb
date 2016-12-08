class Administrator < ApplicationRecord
  include Rolifiable

  belongs_to :user, optional: false

  validates :user_id, presence: true, uniqueness: true
end
