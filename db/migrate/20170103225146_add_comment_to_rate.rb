class AddCommentToRate < ActiveRecord::Migration[5.0]
  def change
    add_column :rates, :comment, :text
  end
end
