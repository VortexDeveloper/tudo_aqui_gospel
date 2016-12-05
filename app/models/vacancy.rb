class Vacancy < ApplicationRecord
  belongs_to :announcer
  enum active: [:s, :n]
end
