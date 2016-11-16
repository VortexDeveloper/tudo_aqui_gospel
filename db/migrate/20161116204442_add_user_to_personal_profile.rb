class AddUserToPersonalProfile < ActiveRecord::Migration[5.0]
  def change
    add_reference :personal_profiles, :user, foreign_key: true
  end
end
