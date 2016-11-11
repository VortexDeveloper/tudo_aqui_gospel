class Insider < ApplicationRecord
  include Rolifiable
  
  belongs_to :user
end
