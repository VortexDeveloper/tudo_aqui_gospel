class Administrator < ApplicationRecord
  include Rolifiable
  
  belongs_to :user
end
