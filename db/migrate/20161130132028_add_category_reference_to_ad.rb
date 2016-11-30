class AddCategoryReferenceToAd < ActiveRecord::Migration[5.0]
  def change
    add_reference :ads, :category, foreign_key: true, null: true
  end
end
