class RemoveUserFromTelephone < ActiveRecord::Migration[5.0]
  def change
    remove_reference :telephones, :user, foreign_key: true
  end
end
