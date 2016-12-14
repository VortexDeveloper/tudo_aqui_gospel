class RemoveUserFromPhonebook < ActiveRecord::Migration[5.0]
  def change
    remove_reference :phonebooks, :user, foreign_key: true
  end
end
