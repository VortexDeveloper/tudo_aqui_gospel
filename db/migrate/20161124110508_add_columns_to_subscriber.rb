class AddColumnsToSubscriber < ActiveRecord::Migration[5.0]
  def change
    add_column :subscribers, :christian, :string
    add_column :subscribers, :church, :string
    add_column :subscribers, :birth_date, :date
    add_column :subscribers, :sex, :string
    add_column :subscribers, :christian_denomination, :string
  end
end
