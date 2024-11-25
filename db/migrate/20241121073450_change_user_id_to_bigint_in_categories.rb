class ChangeUserIdToBigintInCategories < ActiveRecord::Migration[8.0]
  def change
    change_column :categories, :user_id, :bigint
  end
end
