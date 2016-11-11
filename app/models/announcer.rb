class Announcer < ApplicationRecord
  include Rolifiable

  belongs_to :user
end
