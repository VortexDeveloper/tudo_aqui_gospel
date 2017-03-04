class AnnouncerPayment < ApplicationRecord
  belongs_to :announcer
  belongs_to :ad
  enum payment_method: [:credito, :dinheiro, :boleto]
end
