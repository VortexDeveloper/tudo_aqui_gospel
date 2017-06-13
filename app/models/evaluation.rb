class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :announcer

  rails_admin do
    visible false
  end
  
end
