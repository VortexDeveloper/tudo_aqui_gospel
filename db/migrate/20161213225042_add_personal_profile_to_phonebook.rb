class AddPersonalProfileToPhonebook < ActiveRecord::Migration[5.0]
  def change
    add_reference :phonebooks, :personal_profile, foreign_key: true
  end
end
