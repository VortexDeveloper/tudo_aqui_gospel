class Subscriber < ApplicationRecord
  include Rolifiable
  
  belongs_to :user
end
