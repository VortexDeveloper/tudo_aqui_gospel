class AdPlan < ApplicationRecord
  has_many :announcers
  enum plan_type: [:bronze, :silver, :gold]
end
