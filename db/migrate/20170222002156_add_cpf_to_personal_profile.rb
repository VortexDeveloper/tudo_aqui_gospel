class AddCpfToPersonalProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :personal_profiles, :cpf, :string
  end
end
