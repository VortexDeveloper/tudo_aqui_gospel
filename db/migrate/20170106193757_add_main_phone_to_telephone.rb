class AddMainPhoneToTelephone < ActiveRecord::Migration[5.0]
  def change
    add_column :telephones, :main_telephone, :integer, limit: 1, default: 0
  end
end
