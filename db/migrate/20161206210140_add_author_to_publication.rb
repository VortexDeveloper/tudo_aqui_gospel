class AddAuthorToPublication < ActiveRecord::Migration[5.0]
  def change
    add_reference :publications, :author, references: :user, index: true
    add_foreign_key :publications, :users, column: :author_id
  end
end
