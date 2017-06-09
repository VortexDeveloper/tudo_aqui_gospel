class AdPlan < ApplicationRecord
  has_many :announcers, dependent: :destroy
  enum plan_type: [:bronze, :silver, :gold]
end
