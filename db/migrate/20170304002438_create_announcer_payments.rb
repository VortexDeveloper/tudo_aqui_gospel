class CreateAnnouncerPayments < ActiveRecord::Migration[5.0]
  def change
    create_table :announcer_payments do |t|
      t.references :announcer
      t.references :ad
      t.decimal :price
      t.integer :payment_method
      t.date :charge_date
      t.date :paid_date

      t.timestamps
    end
  end
end
