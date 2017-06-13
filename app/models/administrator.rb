class Administrator < ApplicationRecord
  include Rolifiable

  belongs_to :user, optional: false

  validates :user_id, presence: true, uniqueness: true

  rails_admin do
    object_label_method :administrator_label_name
  end

  def administrator_label_name
    "#{user.email}"
  end

end
