class Columnist < ApplicationRecord
  include Rolifiable

  belongs_to :user
end
